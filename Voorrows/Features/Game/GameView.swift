import SwiftUI

struct GameView: View {

    // MARK: - State properties
    let model: GameModel

    // MARK: - View
    var body: some View {
        GameArrowListView(
            state: model.list,
            onSwipe: model.onSwipe
        )
    }

}

// MARK: - Previews
#Preview {
    GameView(
        model: .init(
            gameFactory: .init(
                trapRate: 80
            )
        )
    )
}
