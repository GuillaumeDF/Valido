/// Seule mise du feed, et volontairement la seule. Deux mécanismes ont été écartés et ne
/// doivent pas revenir : l'auto-avance après bonne réponse (retirée le 2026-08-23 — elle
/// vivait ici via `isBlocked` / `advancesAutomatically` / `dismissExplanation()`), et la
/// série quotidienne, qui punit l'absence au lieu de récompenser le travail. Le combo se
/// joue dans la session, jamais sur le calendrier.
nonisolated struct ComboEngine: Sendable, Equatable {
    private(set) var multiplier: Int = 0

    /// Seuil à partir duquel le combo doit devenir visuellement inquiétant à perdre.
    static let hotThreshold = 5

    init() {}

    mutating func answer(correct: Bool) {
        multiplier = correct ? multiplier + 1 : 0
    }

    var isHot: Bool { multiplier >= Self.hotThreshold }
}
