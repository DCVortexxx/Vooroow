import SwiftUI

@Observable @MainActor
class GameModel {

    // MARK: - Sub-types

    // MARK: - Init
    init(
        gameFactory: GameArrowFactory
    ) {
        self.lives = gameFactory.lives
        // For this tech test, I'm assuming that nobody will go further than 1k.
        // In a real app context, we would probably add more content dynamically
        // if the user reaches the last few arrows
        self.arrows = gameFactory.generate(1_000)
        self.currentIndex = 0
    }

    // MARK: - Private properties
    private var lives: Int
    private var arrows: [GameArrowView.Statez]
    private var currentIndex: Int
    private var currentArrow: GameArrowView.Statez {
        get { arrows[currentIndex] }
        set { arrows[currentIndex] = newValue }
    }


    // MARK: - State properties
    var header: GameHeaderView.Statez {
        .init(
            lives: lives
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
        Task {
            if direction == currentArrow.expectedDirection {
                currentArrow.validation = .validated
            } else {
                currentArrow.validation = .failed
                lives -= 1
            }
            try await Task.sleep(for: .seconds(0.35))

            if lives <= 0 {
                // TODO: Maxime: Reset the game
            } else {
                currentIndex += 1
            }
        }
    }

}
