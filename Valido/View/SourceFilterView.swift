import SwiftUI

/// La seule surface de réglage de l'app. Ouverte depuis le libellé du thème, donc sans
/// ajouter un seul pixel de chrome au feed — la spec interdit tout menu et toute décision
/// avant de réviser.
struct SourceFilterView: View {
    let selection: SourceSelection
    let count: (Subject) -> Int
    let onToggle: (Subject) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Sources")
                    .font(.system(.title2, design: .rounded, weight: .bold))
                Text("Tout est coché par défaut. Une source doit rester active.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }

            VStack(spacing: 12) {
                ForEach(Subject.allCases, id: \.self) { subject in
                    Toggle(isOn: Binding(
                        get: { selection.includes(subject) },
                        set: { _ in onToggle(subject) }
                    )) {
                        HStack {
                            Text(Self.label(subject))
                                .font(.system(.body, design: .rounded, weight: .semibold))
                            Spacer()
                            Text("\(count(subject))")
                                .font(.footnote.weight(.semibold))
                                .foregroundStyle(.secondary)
                                .monospacedDigit()
                        }
                    }
                    .tint(.green)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(.quinary, in: .rect(cornerRadius: 14))
                }
            }

            Spacer(minLength: 0)
        }
        .padding(24)
        .presentationDetents([.height(280)])
    }

    /// Le nom affiché est de la présentation, pas du modèle — `Subject` reste un tag brut.
    private static func label(_ subject: Subject) -> String {
        switch subject {
        case .code: "Code de la route"
        case .swift: "Swift & iOS"
        }
    }
}
