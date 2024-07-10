import SwiftUI

@MainActor
struct MenuHistoryView: View {

    // MARK: - Sub-types
    struct Statez: Identifiable {
        let title: String
        let score: Int
        let streak: Int

        var id: String { title }
    }

    // MARK: - State
    let state: Statez

    // MARK: - View
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(state.title)

            HStack {
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
        }
        .font(.title3.bold())
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
    MenuHistoryView(
        state: .init(
            title: "Yesterday (Hard)",
            score: 10,
            streak: 3
        )
    )
    .background(.gameBackground)
    .foregroundStyle(.white)
}
