import SwiftUI

/// Une rampe continue et non un flag chaud/pas chaud : sinon ×5 et ×50 se peignent
/// identiquement. `ComboEngine.isHot` n'est que le départ de la rampe.
struct ComboBadge: View {
    let combo: ComboEngine

    private static let rampCeiling = 20
    private static let secondBeat = 15

    private var progress: Double {
        guard combo.isHot else { return 0 }
        let span = Double(Self.rampCeiling - ComboEngine.hotThreshold)
        return min(1, Double(combo.multiplier - ComboEngine.hotThreshold) / span)
    }

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
        .scaleEffect(1 + 0.15 * (1 + progress))
        .shadow(color: tint.opacity(0.7 * progress), radius: 8 * progress)
        .animation(.snappy(duration: 0.2), value: combo.multiplier)
        .opacity(combo.multiplier == 0 ? 0.35 : 1)
    }
}
