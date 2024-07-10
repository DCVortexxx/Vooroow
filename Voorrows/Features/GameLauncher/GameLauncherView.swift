import SwiftUI

struct GameLauncherView: View {

    // MARK: - State properties
    let model: GameLauncherModel

    // MARK: - View
    var body: some View {
        @Bindable var model = model
        VStack {
            Picker("Difficulty", selection: $model.difficulty) {
                ForEach(GameLauncherModel.Difficulty.allCases) {
                    Text("\($0)".capitalized)
                }
            }
            .pickerStyle(.segmented)

            Button("Play", action: model.onPlay)
        }
        .padding()
    }

}

// MARK: - Previews
#Preview {
    GameLauncherView(
        model: .init(
            onPlay: { _ in }
        )
    )
}
