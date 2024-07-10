import Foundation

class GameArrowFactory {

    // MARK: - Init
    init(
        difficulty: GameLauncherModel.Difficulty
    ) {
        switch difficulty {
        case .easy:
            self.lives = 10
            self.trapRate = 30
            self.decisionDuration = 8
        case .medium:
            self.lives = 5
            self.trapRate = 50
            self.decisionDuration = 4
        case .hard:
            self.lives = 3
            self.trapRate = 70
            self.decisionDuration = 2.5
        }
    }

    // MARK: - Private properties
    private let trapRate: Int // Percentage
    private let decisionDuration: TimeInterval

    // MARK: - Public methods
    let lives: Int

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
