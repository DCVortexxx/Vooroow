import SwiftUI

@main @MainActor
struct VoorrowsApp: App {

    // MARK: - State properties
    let model: VooroowsAppModel = .init()

    // MARK: - View
    var body: some Scene {
        WindowGroup {
            contentView
                .animation(.default, value: model.root.id)
        }
    }

    @ViewBuilder
    private var contentView: some View {
        switch model.root {
        case .gameLauncher:
            // TODO: Maxime: Replace this when we have the correct view
            GameEndedView(model: .init(
                onPlayAgain: model.onStartGame
            ))
        case .game(let model):
            GameView(model: model)
        case .gameEnded(let model):
            GameEndedView(model: model)
        }
    }
}
