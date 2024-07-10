import SwiftUI

@Observable @MainActor
class GameLauncherModel {

    // MARK: - Sub-types
    enum Difficulty: Identifiable, CaseIterable {
        case easy
        case medium
        case hard

        var id: Self { self }
    }

    // MARK: - Init
    init(
        onPlay: @escaping ((Difficulty) -> Void)
    ) {
        self.difficulty = .medium
        self.onPlayDifficulty = onPlay
    }

    // MARK: - Private properties
    let onPlayDifficulty: (Difficulty) -> Void

    // MARK: - State properties
    var difficulty: Difficulty

    // MARK: - Public actions
    func onPlay() {
        onPlayDifficulty(difficulty)
    }
}
