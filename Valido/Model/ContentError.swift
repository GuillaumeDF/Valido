nonisolated enum ContentError: Error, Equatable, Sendable {
    case emptyBank
    case duplicateID(String)
    case tooFewOptions(String)
    case correctIDNotInOptions(String)
    case emptyExplanation(String)
    case resourceMissing
}
