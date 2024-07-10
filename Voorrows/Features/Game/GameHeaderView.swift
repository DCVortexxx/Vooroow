import SwiftUI

struct GameHeaderView: View {

    // MARK: - Sub-types
    struct Statez {
        let lives: Int
    }

    // MARK: - State
    let state: Statez

    // MARK: - View
    var body: some View {
        HStack {
            Spacer()
            headerContent(
                image: .lives(state.lives),
                value: state.lives.formatted()
            )
            .phaseAnimator(
                [false, true, false],
                trigger: state.lives,
                content: {
                    $0.scaleEffect($1 ? 1.4 : 1)
                },
                animation: { _ in
                    .bouncy
                }
            )
            Spacer()
        }
        .font(.title3.bold())
        .foregroundStyle(.white, .orange)
        .padding()
        .background(.headerBackground)
        .animation(.easeInOut, value: state.lives)
    }

    @ViewBuilder
    private func headerContent(
        image: Image,
        value: String
    ) -> some View {
        HStack(spacing: 2) {
            image
            Text(value)
                .monospacedDigit()
        }
    }

}

// MARK: - Private helpers
private extension Image {
    static func lives(_ count: Int) -> Image {
        .init(systemName: count > 0 ? "heart.circle.fill" : "heart.slash.circle.fill")
    }
}

// MARK: - Previews
#Preview {
    AnimatablePreview()
}

private struct AnimatablePreview: View {

    @State private var lives = 5.0

    private var state: GameHeaderView.Statez {
        .init(
            lives: Int(lives)
        )
    }

    var body: some View {
        VStack {
            GameHeaderView(
                state: state
            )
            .padding()
            .background(.purple)

            Spacer()

            Stepper(
                value: $lives,
                in: 0...100,
                step: 1
            ) { Text("Lives: \(Int(lives))") }

        }
        .padding()
        .frame(maxHeight: 400)
    }
}
