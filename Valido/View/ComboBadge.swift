import SwiftUI

/// §7 demande une intensité visuelle *croissante* à partir de ×5, pas un simple flag
/// "chaud/pas chaud" — sinon ×5 et ×50 se peignent identiquement (constaté sur le terrain :
/// simulations à 40 cartes / 90 % code / 62 % Swift montrent 98 % des sessions franchissant
/// ×5, médiane du pic ×9, p90 ×14). `ComboEngine.isHot` reste le seuil de départ de la
/// rampe ; tout ce qui suit — échelle, couleur, lueur — est une interpolation continue sur
/// `multiplier`, plafonnée à `rampCeiling` pour qu'elle ait fini de monter avant que la
/// plupart des sessions n'atteignent leur pic.
struct ComboBadge: View {
    let combo: ComboEngine

    /// Multiplicateur auquel la rampe atteint son maximum. Choisi au-dessus du p90 (×14)
    /// mesuré en simulation, pour que l'essentiel d'une session voie la montée plutôt
    /// qu'un plafond déjà atteint.
    private static let rampCeiling = 20
    /// Second palier, au milieu de la rampe : au-delà, la flamme se met à pulser — un
    /// battement supplémentaire, distinct de la simple interpolation continue.
    private static let secondBeat = 15

    /// 0 avant le seuil chaud, puis progresse linéairement jusqu'à 1 à `rampCeiling`.
    private var progress: Double {
        guard combo.isHot else { return 0 }
        let span = Double(Self.rampCeiling - ComboEngine.hotThreshold)
        return min(1, Double(combo.multiplier - ComboEngine.hotThreshold) / span)
    }

    /// Orange → rouge braise à mesure que `progress` avance : la couleur elle-même
    /// raconte l'urgence au lieu de rester figée sur le même orange du seuil au plafond.
    private var tint: Color {
        guard combo.isHot else { return .secondary }
        return Color(hue: 0.09 - 0.09 * progress, saturation: 0.9 + 0.1 * progress, brightness: 1)
    }

    var body: some View {
        HStack(spacing: 4) {
            Text("×\(combo.multiplier)")
                .font(.system(.title3, design: .rounded, weight: .heavy))
                .contentTransition(.numericText())
            if combo.isHot {
                Image(systemName: "flame.fill")
                    .symbolEffect(.pulse, options: .repeating, isActive: combo.multiplier >= Self.secondBeat)
            }
        }
        .foregroundStyle(tint)
        // 1.15 au seuil (identique à l'ancien palier fixe), jusqu'à 1.5 au plafond de la rampe.
        .scaleEffect(1 + 0.15 * (1 + progress))
        .shadow(color: tint.opacity(0.7 * progress), radius: 8 * progress)
        .animation(.snappy(duration: 0.2), value: combo.multiplier)
        .opacity(combo.multiplier == 0 ? 0.35 : 1)
    }
}
