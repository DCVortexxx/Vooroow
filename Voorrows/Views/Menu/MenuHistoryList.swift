import SwiftUI

@MainActor
struct MenuHistoryList: View {

    // MARK: - State
    let history: [MenuHistoryView.Statez]

    // MARK: - View
    var body: some View {
        VStack(spacing: 20) {
            ForEach(history) {
                MenuHistoryView(state: $0)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .multilineTextAlignment(.leading)
        .padding()
    }

}

// MARK: - Previews
#Preview {
    MenuHistoryList(
        history: [
            .init(
                title: "Yesterday - Hard",
                score: 3,
                streak: 2
            ),
            .init(
                title: "2024/12/22 - Easy",
                score: 3,
                streak: 2
            ),
            .init(
                title: "2024/12/22 - Hard",
                score: 3,
                streak: 2
            )
        ]
    )
    .background(.gameBackground)
    .foregroundStyle(.white)
}
