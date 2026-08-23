import SwiftUI

struct FeedView: View {
    let model: FeedViewModel
    @Environment(\.scenePhase) private var scenePhase
    @State private var position: Int?
    @State private var filtrantLesSources = false

    /// Hauteur laissée visible du bord supérieur de la carte suivante, pour que rien en bas
    /// de l'écran ne suggère que le flux s'arrête là. Volontairement petit : c'est un indice,
    /// pas un aperçu du contenu (qui gâcherait la surprise de la matière suivante).
    private static let peekHeight: CGFloat = 28

    /// Aucune avance programmatique.
    ///
    /// Jusqu'au 2026-08-23, une bonne réponse déclenchait un `scrollTo` différé de 400 ms, ce
    /// qui demandait un `ScrollViewReader`, une `Task` annulable, une cible en attente et une
    /// détection de relance périmée dans `onChange(of: position)`. Le verdict est désormais
    /// symétrique : le mémo s'affiche dans les deux cas et c'est le balayage de l'utilisateur
    /// qui fait avancer, pour qu'il ait le temps de lire. Toute cette machinerie a donc disparu
    /// — avec, au passage, les trois défauts qui vivaient dedans : le gel du feed, la relance
    /// périmée qui ramenait une carte en arrière, et la course entre annulation et réveil.
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 0) {
                ForEach(Array(model.cards.enumerated()), id: \.element.id) { offset, card in
                    row(card, at: offset)
                }
            }
            .scrollTargetLayout()
        }
        // `.viewAligned` cale sur chaque item quelle que soit sa taille. `.paging` paginerait
        // par multiples de la hauteur du conteneur, ce qui désaligne le calage quand les items
        // sont plus courts que lui — c'est le cas ici à cause de `peekHeight`.
        .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
        .scrollPosition(id: $position)
        .ignoresSafeArea(edges: .bottom)
        .onAppear { model.start() }
        .onChange(of: position) { _, new in
            guard let new else { return }
            model.ensureCards(currentIndex: new)
        }
        .onChange(of: scenePhase) { _, phase in
            if phase != .active { model.flush() }
        }
        .sheet(isPresented: $filtrantLesSources) {
            SourceFilterView(
                selection: model.selection,
                count: { model.count(of: $0) },
                onToggle: { subject in
                    var nouvelle = model.selection
                    nouvelle.toggle(subject)
                    model.apply(nouvelle, currentIndex: position ?? 0)
                }
            )
        }
    }

    /// Extraite du `ForEach` : inline, l'expression du corps devenait assez grosse pour que
    /// le vérificateur de types de Swift abandonne ("unable to type-check in reasonable time").
    @ViewBuilder
    private func row(_ card: Card, at index: Int) -> some View {
        switch card {
        case .question(let presented):
            QuestionCardView(
                presented: presented,
                combo: model.combo,
                onAnswer: { model.answer($0, at: index) },
                onTopicTap: { filtrantLesSources = true }
            )
            .containerRelativeFrame(.vertical) { length, _ in length - Self.peekHeight }
            .id(index)
        }
    }
}
