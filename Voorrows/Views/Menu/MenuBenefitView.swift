import SwiftUI

@MainActor
struct MenuBenefitView: View {

    // MARK: - Sub-types
    struct Statez: Identifiable {
        let id: UUID
        let image: (name: String, reversed: Bool)
        let title: String
        let description: String
    }

    // MARK: - State
    let state: Statez

    // MARK: - View
    var body: some View {
        HStack {
            Image(systemName: state.image.name)
                .foregroundStyle(
                    state.image.reversed ? .white : .orange,
                    state.image.reversed ? .orange : .white
                )
                .font(.title.bold())
                .frame(width: 40)

            VStack(alignment: .leading) {
                Text(state.title)
                    .font(.title3.bold())
                Text(state.description)
                    .foregroundStyle(.secondary)
                    .font(.body.bold())
            }
        }
    }

}

// MARK: - Previews
#Preview {
    MenuBenefitView(
        state: .init(
            id: .init(),
            image: ("brain.head.profile.fill", false),
            title: "Attention",
            description: "Improves focus by tracking rapidly changing arrows"
        )
    )
    .background(.gameBackground)
    .foregroundStyle(.white)
}
