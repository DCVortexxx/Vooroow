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
        case .medium:
            self.lives = 5
            self.trapRate = 50
        case .hard:
            self.lives = 3
            self.trapRate = 70
        }
    }

    // MARK: - Private properties
    let trapRate: Int // Percentage

    // MARK: - Public methods
    let lives: Int

    func generate(_ count: Int) -> [GameArrowView.Statez] {
        (0..<count).map { _ in
            .init(
                id: .init(),
                direction: .random,
                validation: .none,
                isTrap: Int.random(in: 0..<100) <= trapRate
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
