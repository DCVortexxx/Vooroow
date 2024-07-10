import SwiftUI

@Observable @MainActor
class VooroowsAppModel {

    // MARK: - Sub-types
    enum Root: Identifiable {
        case gameLauncher(GameLauncherModel)
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
        self.root = .none
        self.root = gameLauncher()
    }

    // MARK: - State properties
    // TODO: Maxime: Save the difficulty on the device, to keep it accross launches
    private var currentDifficulty: GameLauncherModel.Difficulty = .medium
    private(set) var root: Root!

    // MARK: - Public actions
    func onStartGame() {
        root = game()
    }

    func onGameEnded() {
        root = gameEnded()
    }

    // MARK:  - Root factories
    private func gameLauncher() -> Root {
        .gameLauncher(.init(
            onPlay: { [weak self] in
                self?.currentDifficulty = $0
                self?.root = self?.game()
            }
        ))
    }

    private func game() -> Root {
        .game(.init(
            gameFactory: .init(
                difficulty: currentDifficulty
            ),
            onGameEnd: { [weak self] in
                self?.onGameEnded()
            }
        ))
    }

    private func gameEnded() -> Root {
        .gameEnded(.init(
            onPlayAgain: { [weak self] in
                self?.onStartGame()
            }
        ))
    }

}
