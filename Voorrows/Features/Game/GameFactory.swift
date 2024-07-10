import Foundation

class GameArrowFactory {

    // MARK: - Init
    init(
        trapRate: Int = 30 // Percent
    ) {
        self.trapRate = trapRate
    }

    // MARK: - Private properties
    let trapRate: Int

    // MARK: - Public methods
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
