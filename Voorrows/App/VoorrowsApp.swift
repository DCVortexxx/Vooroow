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
        case .gameLauncher(let model):
            GameLauncherView(model: model)
        case .game(let model):
            GameView(model: model)
        case .gameEnded(let model):
            GameEndedView(model: model)
        case .none:
            fatalError("This is a developper error and should be caught as soon as possible.")
        }
    }
}
