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
        case .gameLauncher(let model, let benefits):
            GameLauncherView(model: model) {
                MenuBenefitsList(benefits: benefits)
            }
        case .game(let model):
            GameView(model: model)
        case .gameEnded(let model, let history):
            GameLauncherView(model: model) {
                MenuHistoryList(history: history)
            }
        case .none:
            fatalError("This is a developper error and should be caught as soon as possible.")
        }
    }
}
