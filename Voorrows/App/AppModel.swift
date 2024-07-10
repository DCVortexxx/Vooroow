import SwiftUI
import SwiftData

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

    // MARK: - Private properties
    // TODO: Maxime: Save the difficulty on the device, to keep it accross launches
    private var currentDifficulty: GameLauncherModel.Difficulty = .medium
    private let modelContainer: ModelContainer = .app()

    // MARK: - State properties
    private(set) var root: Root!

    // MARK:  - Root factories
    private func gameLauncher() -> Root {
        .gameLauncher(.init(
            modelContainer: modelContainer,
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
                self?.onGameEnded(result: $0)
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

    // MARK: - Private actions
    func onStartGame() {
        root = game()
    }

    func onGameEnded(result: GameResult) {
        result.save(in: modelContainer.mainContext)
        root = gameEnded()
    }

}
