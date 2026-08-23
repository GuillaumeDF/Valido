nonisolated struct SchedulerConfig: Sendable, Equatable {
    /// Part des tirages pondérés par la faiblesse. Le reste est uniforme.
    var weightedShare: Double
    /// Nombre de cartes récentes exclues des deux tirages.
    var recentWindow: Int
    /// Nombre de cartes servies au bout duquel une question retrouve son poids plein.
    var recencyHorizon: Double
    /// Poids d'ancienneté minimal : garantit qu'aucune question ne disparaît.
    var recencyFloor: Double
    /// Poids d'échec d'une question jamais vue.
    var unseenFailureWeight: Double
    /// Poids d'échec d'une question sans aucune faute.
    var baseFailureWeight: Double
    /// Amplitude ajoutée au poids d'échec par le taux de faute.
    var failureSpan: Double

    init(
        weightedShare: Double = 0.7,
        recentWindow: Int = 25,
        recencyHorizon: Double = 60,
        recencyFloor: Double = 0.05,
        unseenFailureWeight: Double = 3.0,
        baseFailureWeight: Double = 0.3,
        failureSpan: Double = 2.7
    ) {
        self.weightedShare = weightedShare
        self.recentWindow = recentWindow
        self.recencyHorizon = recencyHorizon
        self.recencyFloor = recencyFloor
        self.unseenFailureWeight = unseenFailureWeight
        self.baseFailureWeight = baseFailureWeight
        self.failureSpan = failureSpan
    }
}
