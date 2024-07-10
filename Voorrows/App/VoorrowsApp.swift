import SwiftUI

@main
struct VoorrowsApp: App {

    // MARK: - View
    var body: some Scene {
        WindowGroup {
            GameView(
                model: .init(
                    gameFactory: .init()
                )
            )
        }
    }
}
