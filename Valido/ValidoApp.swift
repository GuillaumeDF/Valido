import SwiftUI

@main
struct ValidoApp: App {
    @State private var model: FeedViewModel?
    @State private var failure: String?

    var body: some Scene {
        WindowGroup {
            Group {
                if let model {
                    FeedView(model: model)
                } else if let failure {
                    ContentErrorView(message: failure)
                } else {
                    ProgressView().task { load() }
                }
            }
        }
    }

    private func load() {
        do {
            let bank = try QuestionBank.bundled()
            let store = FileProgressStore(url: try FileProgressStore.defaultURL())
            model = FeedViewModel(bank: bank, store: store,
                                  selectionStore: DefaultsSourceSelectionStore())
        } catch {
            failure = String(describing: error)
        }
    }
}
