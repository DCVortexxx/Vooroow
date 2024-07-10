import Foundation

class GameArrowFactory {

    // MARK: - Init
    init(
        lives: Int = 5,
        trapRate: Int = 30 // Percent
    ) {
        self.lives = lives
        self.trapRate = trapRate
    }

    // MARK: - Private properties
    let trapRate: Int

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
