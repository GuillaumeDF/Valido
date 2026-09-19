import Foundation

/// La part uniforme (`1 - weightedShare`) est inconditionnelle : c'est elle qui empêche le
/// tirage de devenir devinable, et un feed dont on prévoit la carte suivante cesse d'en
/// être un. Même raison pour `recencyFloor`, qui garde une question maîtrisée tirable.
nonisolated struct CardScheduler: Sendable {
    let config: SchedulerConfig

    init(config: SchedulerConfig = SchedulerConfig()) {
        self.config = config
    }

    func next(
        bank: QuestionBank,
        progress: ProgressSnapshot,
        recent: [Question.ID],
        selection: SourceSelection = SourceSelection(),
        rng: inout some RandomNumberGenerator
    ) -> ScheduledCard {
        let pool = eligible(in: bank, recent: recent, selection: selection)
        let uniforme = Double.random(in: 0..<1, using: &rng) >= config.weightedShare

        let choisie = uniforme
            ? pool.randomElement(using: &rng)!
            : weightedPick(from: pool, progress: progress, rng: &rng)

        let présentée = PresentedQuestion(
            question: choisie,
            displayOptions: choisie.options.shuffled(using: &rng)
        )

        return ScheduledCard(card: .question(présentée), draw: uniforme ? .uniform : .weighted)
    }

    func weight(for id: Question.ID, progress: ProgressSnapshot) -> Double {
        let stats = progress.stats(for: id)

        guard let lastServeIndex = stats.lastServeIndex else {
            return config.unseenFailureWeight
        }

        let échec = config.baseFailureWeight + config.failureSpan * stats.failureRate
        let écoulé = Double(progress.serveIndex - lastServeIndex)
        let ancienneté = max(config.recencyFloor, min(1.0, écoulé / config.recencyHorizon))

        return échec * ancienneté
    }

    func boost(for question: Question, progress: ProgressSnapshot) -> Double {
        guard question.role == .fondation, !progress.estAcquise(question.notion) else { return 1.0 }
        return config.foundationBoost
    }

    /// Restreint aux sources activées, puis retire les `recentWindow` dernières cartes
    /// servies. Si plus rien n'est éligible — vivier plus petit que la fenêtre — la fenêtre
    /// est tronquée par son extrémité la plus ancienne jusqu'à ce qu'un tirage redevienne
    /// possible.
    private func eligible(
        in bank: QuestionBank,
        recent: [Question.ID],
        selection: SourceSelection
    ) -> [Question] {
        let source = bank.questions.filter { selection.includes($0.subject) }
        // Une sélection sans correspondance dans la banque (banque mono-matière en test,
        // matière retirée d'un futur import) ne doit pas faire planter le tirage.
        guard !source.isEmpty else { return bank.questions }

        var fenêtre = Array(recent.suffix(config.recentWindow))

        while true {
            let exclus = Set(fenêtre)
            let pool = source.filter { !exclus.contains($0.id) }
            if !pool.isEmpty { return pool }
            if fenêtre.isEmpty { return source }
            fenêtre.removeFirst()
        }
    }

    private func weightedPick(
        from pool: [Question],
        progress: ProgressSnapshot,
        rng: inout some RandomNumberGenerator
    ) -> Question {
        let poids = pool.map { weight(for: $0.id, progress: progress) * boost(for: $0, progress: progress) }
        let total = poids.reduce(0, +)

        guard total > 0 else { return pool.randomElement(using: &rng)! }

        var tirage = Double.random(in: 0..<total, using: &rng)
        for (question, poidsQuestion) in zip(pool, poids) {
            tirage -= poidsQuestion
            if tirage < 0 { return question }
        }
        return pool[pool.count - 1]
    }
}
