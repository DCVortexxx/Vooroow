import SwiftUI

@Observable @MainActor
class VooroowsAppModel {

    // MARK: - Sub-types
    enum Root: Identifiable {
        case gameLauncher
        case game(GameModel)
        case gameEnded(GameEndedModel)

        var id: Int {
            switch self {
            case .gameLauncher: return 0
            case .game: return 1
            case .gameEnded: return 2
            }
        }
    }

    // MARK: - Init
    init() {
        self.root = .gameLauncher
    }

    // MARK: - State properties
    private(set) var root: Root

    // MARK: - Public actions
    func onStartGame() {
        root = game()
    }

    func onGameEnded() {
        root = gameEnded()
    }

    // MARK:  - Root factories
    private func gameLauncher() -> Root {
        .gameLauncher
    }

    private func game() -> Root {
        .game(.init(
            gameFactory: .init(),
            onGameEnd: { [weak self] in
                self?.onGameEnded()
            })
        )
    }

    private func gameEnded() -> Root {
        .gameEnded(.init(
            onPlayAgain: { [weak self] in
                self?.onStartGame()
            })
        )
    }

}
