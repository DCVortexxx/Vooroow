import SwiftUI
import SwiftData

@Observable @MainActor
class GameLauncherModel {

    // MARK: - Sub-types
    enum Difficulty: Identifiable, CaseIterable {
        case easy
        case medium
        case hard

        var id: Self { self }
    }

    struct Benefit: Identifiable {
        let image: (name: String, reversed: Bool)
        let title: String
        let description: String

        var id: String { image.name + title + description }
    }

    // MARK: - Init
    init(
        modelContainer: ModelContainer,
        onPlay: @escaping ((Difficulty) -> Void)
    ) {
        self.difficulty = .medium
        self.benefits = [
            .init(
                image: ("brain.head.profile.fill", false),
                title: "Attention",
                description: "Improves focus by tracking rapidly changing arrows"
            ),
            .init(
                image: ("hand.draw.fill", true),
                title: "Hand-Eye Coordination",
                description: "Trains coordination between visual input and hand movements"
            ),
            .init(
                image: ("figure.run.circle.fill", false),
                title: "Reflexes",
                description: "Enhances the brain's ability to process information quickly"
            )
        ]
        self.onPlayDifficulty = onPlay
        self.score = GameResult.bestScore(in: modelContainer.mainContext)
        self.streak = GameResult.bestStreak(in: modelContainer.mainContext)
    }

    // MARK: - Private properties
    let onPlayDifficulty: (Difficulty) -> Void

    // MARK: - State properties
    var difficulty: Difficulty
    let benefits: [Benefit]
    let score: Int
    let streak: Int

    // MARK: - Public actions
    func onPlay() {
        onPlayDifficulty(difficulty)
    }
}
