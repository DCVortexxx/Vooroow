import SwiftUI

@Observable @MainActor
class GameEndedModel {

    // MARK: - Init
    init(
        onPlayAgain: @escaping (() -> Void)
    ) {
        self.onPlayAgain = onPlayAgain
    }

    // MARK: - Private properties

    // MARK: - State properties

    // MARK: - Public actions
    let onPlayAgain: () -> Void

}
