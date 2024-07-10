import SwiftUI

@Observable @MainActor
class GameModel {

    // MARK: - Init
    init(
        gameFactory: GameArrowFactory,
        onGameEnd: @escaping () -> Void
    ) {
        self.lives = gameFactory.lives
        self.score = 0
        // For this tech test, I'm assuming that nobody will go further than 1k.
        // In a real app context, we would probably add more content dynamically
        // if the user reaches the last few arrows
        self.arrows = gameFactory.generate(1_000)
        self.currentIndex = 0
        self.onGameEnd = onGameEnd
        self.currentArrow.validation = .pending
        self.scheduleCurrentArrowExpiration()
    }

    // MARK: - Private properties
    private var lives: Int
    private var score: Int
    private var arrows: [GameArrowView.Statez]
    private var currentIndex: Int
    private var currentArrow: GameArrowView.Statez {
        get { arrows[currentIndex] }
        set { arrows[currentIndex] = newValue }
    }
    private var currentArrowExpiredTask: Task<Void, Error>?
    private let onGameEnd: () -> Void

    // MARK: - State properties
    var header: GameHeaderView.Statez {
        .init(
            lives: lives,
            score: score
        )
    }

    var list: GameArrowListView.Statez {
        .init(
            emphasized: currentArrow.id,
            arrows: arrows
        )
    }

    // MARK: - Public actions
    func onSwipe(direction: GameArrowView.Direction) {
        guard lives > 0 else { return }

        currentArrowExpiredTask?.cancel()
        Task {
            try await validateArrow(direction == currentArrow.expectedDirection)
        }
    }

    // MARK: - Private helpers
    private func validateArrow(_ isValid: Bool) async throws {
        if isValid {
            currentArrow.validation = .validated
            score += 1
        } else {
            currentArrow.validation = .failed
            lives -= 1
        }

        try await Task.sleep(for: .seconds(0.35))

        if lives <= 0 {
            onGameEnd()
        } else {
            currentIndex += 1
            currentArrow.validation = .pending
            scheduleCurrentArrowExpiration()
        }
    }

    private func scheduleCurrentArrowExpiration() {
        currentArrowExpiredTask = Task {
            try await Task.sleep(for: .seconds(currentArrow.decisionDuration))
            try await validateArrow(false)
        }
    }

}
