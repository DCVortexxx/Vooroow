import SwiftUI

@MainActor
struct GameLauncherView: View {

    // MARK: - State properties
    let model: GameLauncherModel

    // MARK: - View
    var body: some View {
        @Bindable var model = model
        VStack(spacing: 20) {
            titleView
            HStack(spacing: 20) {
                logoView
                statsView
            }
            benefitsView
            Spacer()
            difficultyPicker
            playButton
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundStyle(.white)
        .background(.gameBackground)
    }

    @ViewBuilder
    private var titleView: some View {
        Text("Vooroows")
            .font(.title.bold())
            .padding(.bottom)
            .frame(maxWidth: .infinity)
            .background(.headerBackground)
    }

    @ViewBuilder
    private var logoView: some View {
        Image.logo
            .font(.system(size: 80))
            .shadow(radius: 1, x: 2, y: 2)
            .foregroundStyle(.arrowDefault, .arrowTrap)
            .padding(30)
            .background(.arrowBackground)
            .clipShape(.circle)
    }

    @ViewBuilder
    private var statsView: some View {
        VStack(alignment: .leading, spacing: 10) {
            statContent(
                image: .score,
                value: model.score.formatted()
            )
            .foregroundStyle(.white, .scoreBackground)
            statContent(
                image: .streak,
                value: model.streak.formatted()
            )
            .foregroundStyle(.white, .streakBackground)
        }
        .font(.title.bold())
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

    @ViewBuilder
    private var benefitsView: some View {
        VStack(spacing: 20) {
            ForEach(model.benefits) {
                benefitView($0)
            }
        }
        .multilineTextAlignment(.leading)
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    @ViewBuilder
    private func benefitView(_ benefit: GameLauncherModel.Benefit) -> some View {
        HStack {
            Image(systemName: benefit.image.name)
                .foregroundStyle(
                    benefit.image.reversed ? .white : .orange,
                    benefit.image.reversed ? .orange : .white
                )
                .font(.title.bold())
                .frame(width: 40)
            VStack(alignment: .leading) {
                Text(benefit.title)
                    .font(.title3.bold())
                Text(benefit.description)
                    .foregroundStyle(.secondary)
                    .font(.body.bold())
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    @ViewBuilder
    private var difficultyPicker: some View {
        HStack(spacing: 20) {
            ForEach(GameLauncherModel.Difficulty.allCases) {
                difficultyButton($0)
            }
        }
        .sensoryFeedback(.selection, trigger: model.difficulty)
    }

    @ViewBuilder
    private func difficultyButton(_ difficulty: GameLauncherModel.Difficulty) -> some View {
        Button(action: { model.difficulty = difficulty }) {
            VStack {

                Image(difficulty: difficulty)
                    .font(.system(size: 30))
                    .padding()
                    .background(
                        Color.difficultyPicker(selected: difficulty == model.difficulty)
                    )
                    .clipShape(.circle)

                Text(difficulty.name)

            }
            .foregroundStyle(.white, .scoreBackground)
            .opacity(difficulty == model.difficulty ? 1 : 0.75)
        }
        .buttonStyle(ScalingButton())
    }

    @ViewBuilder
    private var playButton: some View {
        Button("Let's get started!") {
            model.onPlay()
        }
        .buttonStyle(DefaultButton())
    }

}

// MARK: - Private helpers
private extension Image {

    static var logo: Image {
        .init(systemName: "arrow.down.left.arrow.up.right")
    }

    init(difficulty: GameLauncherModel.Difficulty) {
        switch difficulty {
        case .easy:     self = .init(systemName: "gauge.with.dots.needle.0percent")
        case .medium:   self = .init(systemName: "gauge.with.dots.needle.33percent")
        case .hard:     self = .init(systemName: "gauge.with.dots.needle.67percent")
        }
    }

}

private extension GameLauncherModel.Difficulty {

    var name: String {
        switch self {
        case .easy:     return "Easy"
        case .medium:   return "Medium"
        case .hard:     return "Hard"
        }
    }

}

private extension Color {

    static func difficultyPicker(selected: Bool) -> Color {
        selected ? .difficultyPickerBackgroundSelected : .difficultyPickerBackground
    }

}

// MARK: - Previews
#Preview {
    GameLauncherView(
        model: .init(
            modelContainer: .preview(),
            onPlay: { _ in }
        )
    )
}
