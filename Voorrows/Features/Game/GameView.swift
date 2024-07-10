import SwiftUI

struct GameView: View {

    // MARK: - State properties
    let model: GameModel

    // MARK: - View
    var body: some View {
        VStack {
            GameHeaderView(
                state: model.header
            )
            Spacer()
            GameArrowListView(
                state: model.list,
                onSwipe: model.onSwipe
            )
            .frame(maxWidth: .infinity)
            Spacer()
        }
        .background(.gameBackground)
    }

}

// MARK: - Previews
#Preview {
    GameView(
        model: .init(
            gameFactory: .init(
                difficulty: .hard
            ),
            onGameEnd: { }
        )
    )
}
