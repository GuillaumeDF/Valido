/// Le combo, seule mise du feed : chaque bonne réponse l'incrémente, une faute le remet à zéro.
///
/// Il ne pilote plus l'avance. Jusqu'au 2026-08-23 le verdict était asymétrique — une bonne
/// réponse enchaînait seule, une faute bloquait sur l'explication — et ce type portait cette
/// règle via `isBlocked` / `advancesAutomatically` / `dismissExplanation()`. Le verdict est
/// désormais symétrique : juste ou faux, le mémo s'affiche et c'est le balayage de
/// l'utilisateur qui fait avancer, pour qu'il ait le temps de lire. Les trois membres qui
/// n'existaient que pour piloter l'auto-avance ont donc disparu avec elle.
///
/// La mise reste réelle : perdre un ×12 est la punition d'une faute, l'interruption n'était
/// pas la seule sanction.
///
/// Pas de série quotidienne, et c'est un refus : une série qui compte les jours punit
/// l'absence, et le jour où elle casse on referme l'app. Le combo se joue dans la session,
/// jamais sur le calendrier.
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
