import SwiftUI

struct ScalingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .font(.body.bold())
            .animation(.easeOut(duration: 0.2)) {
                $0.scaleEffect(configuration.isPressed ? 0.9 : 1)
            }
    }
}

