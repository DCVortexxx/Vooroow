import SwiftUI

@MainActor
struct MenuLogoView: View {

    // MARK: - View
    var body: some View {
        Image.logo
            .font(.system(size: 80))
            .shadow(radius: 1, x: 2, y: 2)
            .foregroundStyle(.arrowDefault, .arrowTrap)
            .padding(30)
            .background(.arrowBackground)
            .clipShape(.circle)
    }

}

// MARK: - Private helpers
private extension Image {

    static var logo: Image {
        .init(systemName: "arrow.down.left.arrow.up.right")
    }

}

// MARK: - Previews
#Preview {
    MenuLogoView()
        .foregroundStyle(.white)
}
