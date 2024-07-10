import SwiftUI

@MainActor
struct MenuHeaderView: View {

    // MARK: - View
    var body: some View {
        Text("Vooroows")
            .font(.title.bold())
            .padding(.bottom)
            .frame(maxWidth: .infinity)
            .background(.headerBackground)
    }

}

// MARK: - Previews
#Preview {
    VStack {
        MenuHeaderView()
            .foregroundStyle(.white)
        Spacer()
    }
}
