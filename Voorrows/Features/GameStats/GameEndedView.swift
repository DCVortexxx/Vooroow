import SwiftUI

@MainActor
struct GameEndedView: View {

    // MARK: - State properties
    let model: GameEndedModel

    // MARK: - View
    var body: some View {
        Button("Play again", action: model.onPlayAgain)
    }

}

// MARK: - Previews
#Preview {
    GameEndedView(
        model: .init(
            onPlayAgain: { }
        )
    )
}
