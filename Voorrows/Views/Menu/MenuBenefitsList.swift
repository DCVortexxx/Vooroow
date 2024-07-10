import SwiftUI

@MainActor
struct MenuBenefitsList: View {

    // MARK: - State
    let benefits: [MenuBenefitView.Statez]

    // MARK: - View
    var body: some View {
        VStack(spacing: 20) {
            ForEach(benefits) {
                MenuBenefitView(state: $0)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .multilineTextAlignment(.leading)
        .padding()
    }

}

// MARK: - Helpers
extension [MenuBenefitView.Statez] {

    static var all: Self { [
        .init(
            id: .init(),
            image: ("brain.head.profile.fill", false),
            title: "Attention",
            description: "Improves focus by tracking rapidly changing arrows"
        ),
        .init(
            id: .init(),
            image: ("hand.draw.fill", true),
            title: "Hand-Eye Coordination",
            description: "Trains coordination between visual input and hand movements"
        ),
        .init(
            id: .init(),
            image: ("figure.run.circle.fill", false),
            title: "Reflexes",
            description: "Enhances the brain's ability to process information quickly"
        )
    ] }

}

// MARK: - Previews
#Preview {
    MenuBenefitsList(
        benefits: .all
    )
    .background(.gameBackground)
    .foregroundStyle(.white)
}
