import SwiftUI
import SwiftData

@Observable @MainActor
class VooroowsAppModel {

    // MARK: - Sub-types
    enum Root: Identifiable {
        case gameLauncher(GameLauncherModel, [MenuBenefitView.Statez])
        case game(GameModel)
        case gameEnded(GameLauncherModel, [MenuHistoryView.Statez])

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
        .gameLauncher(
            .init(
                modelContainer: modelContainer,
                stats: .init(
                    title: "Best",
                    score: GameResult.bestScore(in: modelContainer.mainContext),
                    streak: GameResult.bestStreak(in: modelContainer.mainContext)
                ),
                playAction: "Let's get started!",
                onPlay: { [weak self] in
                    self?.onStartGame(difficulty: $0)
                }
            ),
            .all
        )
    }

    private func game() -> Root {
        .game(
            .init(
                gameFactory: .init(
                    difficulty: currentDifficulty
                ),
                onGameEnd: { [weak self] in
                    self?.onGameEnded(result: $0)
                }
            )
        )
    }

    private func gameEnded(result: GameResult) -> Root {
        .gameEnded(
            .init(
                modelContainer: modelContainer,
                stats: .init(
                    title: result.difficulty,
                    score: result.score,
                    streak: result.streak
                ),
                playAction: "Play again",
                onPlay: { [weak self] in
                    self?.onStartGame(difficulty: $0)
                }
            ),
            GameResult
                .history(in: modelContainer.mainContext)
                .dropFirst()
                .map {
                    .init(
                        title: "\($0.timestamp.formatted()) - \($0.difficulty)",
                        score: $0.score,
                        streak: $0.streak
                    )
                }
        )
    }

    // MARK: - Private actions
    func onStartGame(difficulty: GameLauncherModel.Difficulty) {
        currentDifficulty = difficulty
        root = game()
    }

    func onGameEnded(result: GameResult) {
        result.save(in: modelContainer.mainContext)
        root = gameEnded(result: result)
    }

}
