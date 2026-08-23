/// Les sources de questions activées. Tout est coché par défaut.
///
/// L'invariant « jamais vide » vit ici et non dans l'interface : un vivier vide ne
/// laisserait rien à tirer au scheduler, et c'est le genre de garde qu'on oublie de
/// remettre quand on refait l'écran. Décocher la dernière source est donc un no-op.
nonisolated struct SourceSelection: Codable, Sendable, Equatable {
    private(set) var subjects: Set<Subject>

    init(_ subjects: Set<Subject> = Set(Subject.allCases)) {
        self.subjects = subjects.isEmpty ? Set(Subject.allCases) : subjects
    }

    func includes(_ subject: Subject) -> Bool { subjects.contains(subject) }

    mutating func toggle(_ subject: Subject) {
        if subjects.contains(subject) {
            guard subjects.count > 1 else { return }
            subjects.remove(subject)
        } else {
            subjects.insert(subject)
        }
    }
}
