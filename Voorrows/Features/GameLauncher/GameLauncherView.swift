import SwiftUI

@MainActor
struct GameLauncherView<Content: View>: View {

    // MARK: - State properties
    let model: GameLauncherModel
    let content: () -> Content

    init(
        model: GameLauncherModel,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.model = model
        self.content = content
    }

    // MARK: - View
    var body: some View {
        @Bindable var model = model
        VStack {
            MenuHeaderView()
            ScrollView {
                HStack(spacing: 50) {
                    MenuLogoView()
                    MenuStatsView(state: model.stats)
                }
                content()
            }
            MenuDifficultyPicker(
                state: model.difficulty,
                onSelection: model.onDifficultyChange
            )
            playButton
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundStyle(.white)
        .background(.gameBackground)
    }

    @ViewBuilder
    private var playButton: some View {
        Button(model.playAction) {
            model.onPlay()
        }
        .buttonStyle(DefaultButton())
    }

}

// MARK: - Previews
#Preview {
    GameLauncherView(
        model: .init(
            modelContainer: .preview(),
            stats: .init(
                title: "Title",
                score: 134,
                streak: 8
            ),
            playAction: "Let's get started!",
            onPlay: { _ in }
        ),
        content: {
            Text("Placeholder content that is scrollable")
        }
    )
}
