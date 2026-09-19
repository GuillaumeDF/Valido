import SwiftUI

struct FeedView: View {
    let model: FeedViewModel
    @Environment(\.scenePhase) private var scenePhase
    @State private var position: Int?
    @State private var filtrantLesSources = false

    private static let peekHeight: CGFloat = 28

    /// Aucune avance programmatique : le verdict est symétrique et c'est le balayage qui
    /// fait avancer, pour qu'on ait le temps de lire. L'auto-avance retirée le 2026-08-23
    /// emportait un `ScrollViewReader`, une `Task` annulable et une détection de relance
    /// périmée — ne pas les réintroduire.
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 0) {
                ForEach(Array(model.cards.enumerated()), id: \.element.id) { offset, card in
                    row(card, at: offset)
                }
            }
            .scrollTargetLayout()
        }
        // Pas `.paging` : il pagine par multiples de la hauteur du conteneur, donc désaligne
        // le calage dès que les items sont plus courts — ce que `peekHeight` garantit.
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

    /// Extraite du `ForEach` : inline, le vérificateur de types abandonne.
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
