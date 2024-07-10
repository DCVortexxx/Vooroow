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

    // MARK: - Init
    init(
        modelContainer: ModelContainer,
        stats: MenuStatsView.Statez,
        playAction: String,
        onPlay: @escaping ((Difficulty) -> Void)
    ) {
        self.selectedDifficulty = .medium
        self.stats = stats
        self.playAction = playAction
        self.onPlayDifficulty = onPlay
    }

    // MARK: - Private properties
    private var selectedDifficulty: Difficulty
    let onPlayDifficulty: (Difficulty) -> Void

    // MARK: - State properties
    let stats: MenuStatsView.Statez
    var difficulty: MenuDifficultyPicker.Statez {
        .init(
            difficulties: Difficulty.allCases,
            selected: selectedDifficulty
        )
    }
    let playAction: String

    // MARK: - Public actions
    func onDifficultyChange(_ difficulty: Difficulty) {
        selectedDifficulty = difficulty
    }

    func onPlay() {
        onPlayDifficulty(selectedDifficulty)
    }

}
