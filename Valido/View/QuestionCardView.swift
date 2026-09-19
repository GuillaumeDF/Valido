import SwiftUI

struct QuestionCardView: View {
    let presented: PresentedQuestion
    let combo: ComboEngine
    let onAnswer: (Option.ID) -> Bool
    /// Sans affordance visuelle, délibérément : ce serait le premier pixel de chrome.
    let onTopicTap: () -> Void

    @State private var chosenID: Option.ID?
    @State private var wasCorrect: Bool?
    @Environment(\.openURL) private var openURL

    var body: some View {
        carte
            .padding(.horizontal, 12)
            .padding(.top, 12)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color(.secondarySystemBackground))
            .animation(.snappy(duration: 0.25), value: wasCorrect)
            .sensoryFeedback(.success, trigger: wasCorrect) { _, new in new == true }
            .sensoryFeedback(.error, trigger: wasCorrect) { _, new in new == false }
    }

    /// `clipShape` en plus du `background` : lui seul fait mordre le bandeau d'image dans
    /// les coins arrondis du haut. Sans image il ne change rien.
    private var carte: some View {
        silhouette
            .background(.background, in: .rect(cornerRadius: 28))
            .clipShape(.rect(cornerRadius: 28))
            .shadow(color: .black.opacity(0.08), radius: 16, y: 6)
    }

    /// `hauteurMax` et non une hauteur : à fraction ferme, la quatrième option d'une carte
    /// chargée passait sous le bord. Aucun texte n'étant compressible, c'est l'image qui
    /// cède — le `VStack` sert `contenu` à sa taille idéale, le bandeau prend le reste.
    @ViewBuilder
    private var silhouette: some View {
        if let illustration = presented.question.illustration {
            GeometryReader { geo in
                VStack(spacing: 0) {
                    bandeau(illustration, hauteurMax: hauteurDuBandeau(carte: geo.size.height))
                    contenu
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
        } else {
            VStack(spacing: 0) {
                // Centre les cibles de tap : collées au sommet, elles sont hors de portée
                // du pouce sur un téléphone tenu en main.
                Spacer(minLength: 0)
                contenu
                Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    /// L'`alt` **est** l'énoncé pour qui n'accède pas à l'image, pas une description.
    ///
    /// Le cadre d'abord, l'image en `overlay` : dans l'ordre inverse, `clipped()` rogne le
    /// dessin mais pas la taille de mise en page, donc une image 4:3 réclame `h × 1,33` de
    /// largeur et pousse tout le `VStack` hors de la carte. `Color.clear` n'a pas d'aspect
    /// à défendre.
    private func bandeau(_ illustration: Illustration, hauteurMax: CGFloat) -> some View {
        Color.clear
            .frame(maxWidth: .infinity, maxHeight: hauteurMax)
            .overlay {
                Image(illustration.asset)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            .clipped()
            .accessibilityLabel(illustration.alt)
            .accessibilityAddTraits(.isImage)
    }

    /// Des plafonds, pas des hauteurs (cf. `silhouette`) : sur la carte la plus chargée,
    /// l'après-verdict tombe à 8 %. L'image rétrécit une fois le verdict rendu, elle a
    /// fait son travail et l'explication réclame la place.
    private func hauteurDuBandeau(carte hauteur: CGFloat) -> CGFloat {
        hauteur * (wasCorrect == nil ? 0.38 : 0.18)
    }

    private var contenu: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack {
                Button(action: onTopicTap) {
                    Text(presented.question.topic.uppercased())
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.secondary)
                }
                .buttonStyle(.plain)
                Spacer()
                ComboBadge(combo: combo)
            }

            Text(styled(presented.question.prompt))
                .font(.system(.title2, design: .rounded, weight: .bold))
                // Les trois `fixedSize` de cette vue tiennent la même règle : aucun texte de
                // la carte n'est compressible. Sans eux, le conteneur fige une hauteur d'une
                // ligne pendant sa passe de dimensionnement, puis tronque avec une ellipse au
                // lieu de laisser le `Text` passer à la ligne — une option ou une explication
                // amputée cache précisément ce que la carte doit enseigner.
                .fixedSize(horizontal: false, vertical: true)

            VStack(spacing: 12) {
                ForEach(presented.displayOptions) { option in
                    Button { choose(option) } label: {
                        HStack {
                            Text(styled(option.text))
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                            Spacer()
                            if let symbol = symbol(for: option) {
                                Image(systemName: symbol)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(background(for: option), in: .rect(cornerRadius: 14))
                    }
                    .buttonStyle(.plain)
                    .disabled(chosenID != nil)
                }
            }

            if wasCorrect != nil {
                VStack(alignment: .leading, spacing: 12) {
                    Text(styled(presented.question.explanation))
                        .font(.callout)
                        .fixedSize(horizontal: false, vertical: true)
                    if let url = presented.question.sourceURL {
                        Button { openURL(url) } label: {
                            Label("Approfondir", systemImage: "arrow.up.right")
                                .font(.footnote)
                        }
                        .buttonStyle(.plain)
                        .foregroundStyle(.tint)
                    }
                    Label("Balaie pour continuer", systemImage: "chevron.up")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding()
                .background(.quaternary, in: .rect(cornerRadius: 14))
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    /// `Text(String)` n'interprète jamais le Markdown — seul `Text(LocalizedStringKey)` le
    /// fait, sur des littéraux — d'où le parsing manuel.
    /// `.inlineOnlyPreservingWhitespace` : la syntaxe par défaut interprète aussi les blocs
    /// (un prompt ouvrant sur `#Preview` deviendrait un titre) et mange les espaces.
    private func styled(_ source: String) -> AttributedString {
        (try? AttributedString(
            markdown: source,
            options: .init(interpretedSyntax: .inlineOnlyPreservingWhitespace)
        )) ?? AttributedString(source)
    }

    private func choose(_ option: Option) {
        guard chosenID == nil else { return }
        chosenID = option.id
        wasCorrect = onAnswer(option.id)
    }

    private func symbol(for option: Option) -> String? {
        guard chosenID != nil else { return nil }
        if option.id == presented.question.correctID { return "checkmark.circle.fill" }
        if option.id == chosenID { return "xmark.circle.fill" }
        return nil
    }

    private func background(for option: Option) -> some ShapeStyle {
        guard chosenID != nil else { return AnyShapeStyle(.quinary) }
        if option.id == presented.question.correctID { return AnyShapeStyle(.green.opacity(0.25)) }
        if option.id == chosenID { return AnyShapeStyle(.red.opacity(0.25)) }
        return AnyShapeStyle(.quinary)
    }
}
