import Foundation

class GameArrowFactory {

    // MARK: - Init
    init(
        difficulty: GameLauncherModel.Difficulty
    ) {
        self.difficulty = difficulty
    }

    // MARK: - Private properties
    private var trapRate: Int { // Percentage
        switch difficulty {
        case .easy:     return 10
        case .medium:   return 30
        case .hard:     return 50
        }
    }
    private var decisionDuration: TimeInterval {
        switch difficulty {
        case .easy:     return 6
        case .medium:   return 4
        case .hard:     return 2
        }
    }

    // MARK: - Public methods
    let difficulty: GameLauncherModel.Difficulty
    var lives: Int {
        switch difficulty {
        case .easy:     return 10
        case .medium:   return 5
        case .hard:     return 3
        }
    }

    func generate(_ count: Int) -> [GameArrowView.Statez] {
        (0..<count).map { _ in
            .init(
                id: .init(),
                direction: .random,
                validation: .none,
                isTrap: Int.random(in: 0..<100) <= trapRate,
                // For this tech test, I'm keeping the same decision duration
                // for each arrow. In order to scale the difficulty as the user
                // progresses, we could reduce the duration as we increase $0
                // I didn't want to spend too much time on figuring out a proper
                // ratio for each difficulty level, so I kept it simple.
                decisionDuration: decisionDuration
            )
        }
    }
}

// MARK: - Private helpers
private extension GameArrowView.Direction {
    static var random: Self {
        Self.allCases.randomElement()!
    }
}
