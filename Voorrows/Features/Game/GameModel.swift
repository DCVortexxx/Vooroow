import SwiftUI

@Observable @MainActor
class GameModel {

    // MARK: - Sub-types

    // MARK: - Init
    init(
        gameFactory: GameArrowFactory
    ) {
        self.currentIndex = 0

        // For this tech test, I'm assuming that nobody will go further than 1k.
        // In a real app context, we would probably add more content dynamically
        // if the user reaches the last few arrows
        self.arrows = gameFactory.generate(1_000)
    }

    // MARK: - Private properties
    private var currentIndex: Int
    private var arrows: [GameArrowView.Statez]
    private var currentArrow: GameArrowView.Statez {
        get { arrows[currentIndex] }
        set { arrows[currentIndex] = newValue }
    }


    // MARK: - State properties
    var list: GameArrowListView.Statez {
        .init(
            emphasized: currentArrow.id,
            arrows: arrows
        )
    }

    // MARK: - Public actions
    func onSwipe(direction: GameArrowView.Direction) {
        Task {
            currentArrow.validation = direction == currentArrow.expectedDirection ? .validated : .failed
            try await Task.sleep(for: .seconds(0.35))
            currentIndex += 1
        }
    }

}
