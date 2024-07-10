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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.gameBackground)
    }

}

// MARK: - Previews
#Preview {
    GameView(
        model: .init(
            gameFactory: .init(
                lives: 3,
                trapRate: 80
            )
        )
    )
}
