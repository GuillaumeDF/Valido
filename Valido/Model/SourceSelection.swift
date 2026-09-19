/// L'invariant « jamais vide » vit ici et non dans l'interface : c'est le genre de garde
/// qu'on oublie de remettre en refaisant l'écran. Décocher la dernière source est un no-op.
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
