import SwiftUI

@MainActor
struct MenuStatsView: View {

    // MARK: - Sub-types
    struct Statez {
        let title: String
        let score: Int
        let streak: Int
    }

    // MARK: - State
    let state: Statez

    // MARK: - View
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(state.title)

            statContent(
                image: .score,
                value: state.score.formatted()
            )
            .foregroundStyle(.white, .scoreBackground)

            statContent(
                image: .streak,
                value: state.streak.formatted()
            )
            .foregroundStyle(.white, .streakBackground)
        }
        .font(.title.bold())
    }

    @ViewBuilder
    private func statContent(
        image: Image,
        value: String
    ) -> some View {
        HStack(spacing: 4) {
            image
            Text(value)
                .monospacedDigit()
                .animation(.easeOut, value: value)
        }
    }

}

// MARK: - Previews
#Preview {
    MenuStatsView(
        state: .init(
            title: "Best",
            score: 10,
            streak: 3
        )
    )
    .background(.gameBackground)
    .foregroundStyle(.white)
}
