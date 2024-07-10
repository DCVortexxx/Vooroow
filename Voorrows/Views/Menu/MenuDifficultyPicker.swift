import SwiftUI

@MainActor
struct MenuDifficultyPicker: View {

    // MARK: - Sub-types
    typealias Difficulty = GameLauncherModel.Difficulty

    struct Statez {
        let difficulties: [Difficulty]
        let selected: Difficulty
    }

    // MARK: - State
    let state: Statez

    // MARK: - Actions
    let onSelection: (Difficulty) -> Void

    // MARK: - View
    var body: some View {
        HStack(spacing: 20) {
            ForEach(state.difficulties) {
                difficultyButton($0)
            }
        }
        .sensoryFeedback(.selection, trigger: state.selected)
    }

    @ViewBuilder
    private func difficultyButton(_ difficulty: GameLauncherModel.Difficulty) -> some View {
        Button(action: { onSelection(difficulty) }) {
            VStack {

                Image(difficulty: difficulty)
                    .font(.system(size: 30))
                    .padding()
                    .background(
                        Color.difficultyPicker(
                            selected: difficulty == state.selected
                        )
                    )
                    .clipShape(.circle)

                Text(difficulty.name)

            }
            .foregroundStyle(.white, .scoreBackground)
            .opacity(difficulty == state.selected ? 1 : 0.75)
        }
        .buttonStyle(ScalingButton())
    }

}

// MARK: - Private helpers
private extension Image {

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
    MenuDifficultyPicker(
        state: .init(
            difficulties: MenuDifficultyPicker.Difficulty.allCases,
            selected: .easy
        ),
        onSelection: { _ in }
    )
    .background(.gameBackground)
    .foregroundStyle(.white)
}
