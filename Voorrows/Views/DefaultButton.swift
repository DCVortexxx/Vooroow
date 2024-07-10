import SwiftUI

struct DefaultButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .font(.body.bold())
            .foregroundStyle(.white)
            .padding()
            .padding(.horizontal)
            .background(.defaultButton)
            .clipShape(.capsule)
            .animation(.easeOut(duration: 0.2)) {
                $0.scaleEffect(configuration.isPressed ? 0.9 : 1)
            }
    }
}
