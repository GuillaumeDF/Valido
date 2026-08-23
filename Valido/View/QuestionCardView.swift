import SwiftUI

struct QuestionCardView: View {
    let presented: PresentedQuestion
    let combo: ComboEngine
    let onAnswer: (Option.ID) -> Bool
    /// Le libellé du thème est la seule porte vers les réglages : il indique déjà dans
    /// quelle source on est, donc le taper pour la changer est direct. Aucun indicateur
    /// visuel de tapabilité — ce serait le premier pixel de chrome de l'app.
    let onTopicTap: () -> Void

    @State private var chosenID: Option.ID?
    @State private var wasCorrect: Bool?
    @Environment(\.openURL) private var openURL

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            // Sans ce premier Spacer, le contenu — donc chaque cible de tap — se collait au
            // sommet de l'écran, la zone la moins atteignable au pouce sur un téléphone tenu
            // en main. L'encadrer entre deux Spacer() le centre verticalement à la place.
            Spacer(minLength: 0)

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
                // Même défaut, encore : une fois les options et l'explication protégées par
                // fixedSize, c'est le prompt — le seul Text restant sans cette protection dans
                // ce VStack — qui devenait la nouvelle victime de la compression verticale sur
                // les cartes les plus chargées (observé avec la question Foundation Models :
                // "Pour une sortie structurée avec Foundation Models, on annote le…", tronqué).
                // Aucun texte de contenu de la carte ne doit jamais être compressible en hauteur.
                .fixedSize(horizontal: false, vertical: true)

            VStack(spacing: 12) {
                ForEach(presented.displayOptions) { option in
                    Button { choose(option) } label: {
                        HStack {
                            Text(styled(option.text))
                                .multilineTextAlignment(.leading)
                                // Sans ça, le HStack fige la hauteur de la ligne pendant sa passe
                                // de dimensionnement idéal (une ligne, avant que la largeur finale
                                // — réduite par le Spacer() et l'icône de fin — soit connue), puis
                                // ne propose plus jamais cette hauteur figée au Text : au lieu de
                                // passer à la ligne, il tronque avec une ellipse. `fixedSize`
                                // force le Text à recalculer sa propre hauteur idéale pour la
                                // largeur qu'on lui donne réellement, ce qui le laisse s'étendre
                                // sur plusieurs lignes. Aucune option ne doit jamais être tronquée :
                                // ce qui la distingue de ses sœurs doit rester lisible sans interaction.
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

            // Affiché dès qu'il y a un verdict, juste ou faux : c'est le point du verdict
            // symétrique. On apprend sur les 250 questions, pas seulement sur celles qu'on
            // rate — et rien n'avance tant qu'on n'a pas balayé, donc on a le temps de lire.
            if wasCorrect != nil {
                VStack(alignment: .leading, spacing: 12) {
                    Text(styled(presented.question.explanation))
                        .font(.callout)
                        // Même défaut que pour les options (voir plus haut) : quand une carte a
                        // à la fois des options longues et une explication longue, le VStack
                        // englobant manque de hauteur et comprime ce Text au lieu de le laisser
                        // déborder — d'où une ellipse qui a fait disparaître la fin d'un nom
                        // d'API réel (`SystemLanguageModel.default.availability`, question
                        // "Frameworks iOS" / Foundation Models). Une explication tronquée est le
                        // même défaut qu'une option tronquée : l'app est censée enseigner, pas
                        // cacher la réponse.
                        .fixedSize(horizontal: false, vertical: true)
                    if let url = presented.question.sourceURL {
                        // 150 des 250 questions — toutes les Swift — ont une `sourceURL` ;
                        // aucune question de code n'en a. Le lien vivait auparavant dans la
                        // branche « faux » seule, donc 60 % de la banque avait une note de
                        // cours qu'on ne pouvait atteindre qu'en se trompant.
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

            Spacer(minLength: 0)
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        // La carte flotte sur un plateau (fond `secondarySystemBackground`) au lieu de
        // remplir la page à ras bord : sans marge basse, son bord inférieur affleure le bas
        // de la page — juste assez pour que le sommet arrondi de la carte suivante, qui
        // commence par la même marge de plateau, dépasse dans le "sliver" laissé visible par
        // `FeedView.peekHeight`. Rien de son contenu n'y est lisible (aucun spoiler de
        // matière ou de question, un des trois ressorts de surprise du §7) : seuls le coin
        // arrondi et l'ombre passent, ce qui suffit à sentir qu'il y a une suite.
        .background(.background, in: .rect(cornerRadius: 28))
        .shadow(color: .black.opacity(0.08), radius: 16, y: 6)
        .padding(.horizontal, 12)
        .padding(.top, 12)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color(.secondarySystemBackground))
        .animation(.snappy(duration: 0.25), value: wasCorrect)
        .sensoryFeedback(.success, trigger: wasCorrect) { _, new in new == true }
        .sensoryFeedback(.error, trigger: wasCorrect) { _, new in new == false }
    }

    /// Les questions arrivent en Markdown inline (blocs de code avec des accents graves,
    /// notamment). `Text(String)` n'interprète jamais le Markdown — seul `Text(LocalizedStringKey)`
    /// le fait, pour des littéraux — donc on parse nous-mêmes vers `AttributedString`.
    /// `.inlineOnlyPreservingWhitespace` est nécessaire : la syntaxe par défaut interprète aussi
    /// les blocs (un prompt commençant par `#Preview` deviendrait un titre) et retire les espaces.
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
