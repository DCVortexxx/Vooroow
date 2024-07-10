import SwiftUI

@MainActor
struct GameHeaderView: View {

    // MARK: - Sub-types
    struct Statez {
        let lives: Int
        let score: Int
        let streak: Int
    }

    // MARK: - State
    let state: Statez

    // MARK: - View
    var body: some View {
        HStack(spacing: 20) {
            Spacer()
            livesView
            scoreView
            streakView
            Spacer()
        }
        .font(.title3.bold())
        .foregroundStyle(.white, .orange)
        .padding()
        .background(.headerBackground)
    }

    @ViewBuilder
    private var livesView: some View {
        headerContent(
            image: .lives(state.lives),
            value: state.lives.formatted()
        )
        .phaseAnimator(
            [false, true, false],
            trigger: state.lives,
            content: {
                $0
                    .scaleEffect($1 ? 1.4 : 1)
                    .foregroundStyle(
                        $1 || state.lives <= 0 ? .livesLoss : .white,
                        .livesBackground
                    )
            },
            animation: { _ in
                .bouncy(duration: 0.2)
            }
        )
    }

    @ViewBuilder
    private var scoreView: some View {
        headerContent(
            image: .score,
            value: state.score.formatted()
        )
        .foregroundStyle(.white, .scoreBackground)
    }

    @ViewBuilder
    private var streakView: some View {
        headerContent(
            image: .streak,
            value: state.streak.formatted()
        )
        .phaseAnimator(
            [false, true, false],
            trigger: state.streak == 0,
            content: {
                $0
                    .scaleEffect($1 && state.streak == 0 ? 1.4 : 1)
                    .foregroundStyle(
                        $1 && state.streak == 0 ? .livesLoss : .white,
                        .streakBackground
                    )
            },
            animation: { _ in
                    .bouncy(duration: 0.2)
            }
        )
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
                .animation(.easeOut, value: value)
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
    @State private var score = 50.0
    @State private var streak = 8.0

    private var state: GameHeaderView.Statez {
        .init(
            lives: Int(lives),
            score: Int(score),
            streak: Int(streak)
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

            Stepper(
                value: $score,
                in: 0...100,
                step: 1
            ) { Text("Score: \(Int(score))") }

            Stepper(
                value: $streak,
                in: 0...100,
                step: 1
            ) { Text("Streak: \(Int(streak))") }

        }
        .padding()
        .frame(maxHeight: 400)
    }
}
