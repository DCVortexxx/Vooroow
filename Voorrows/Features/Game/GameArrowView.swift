import SwiftUI

struct GameArrowView: View {

    // MARK: - Sub-types
    enum Direction: CaseIterable, Identifiable {
        case up
        case left
        case right
        case down

        var id: Self { self }
    }

    struct Statez {
        let direction: Direction
    }

    // MARK: - State
    let state: Statez

    // MARK: - View
    var body: some View {
        Image(arrow: state.direction)
            .font(.system(size: 140))
    }

}

// MARK: - Private helpers
private extension Image {

    init(arrow direction: GameArrowView.Direction) {
        switch direction {
        case .up:       self = .init(systemName: "arrow.up")
        case .left:     self = .init(systemName: "arrow.left")
        case .right:    self = .init(systemName: "arrow.right")
        case .down:     self = .init(systemName: "arrow.down")
        }
    }
}

// MARK: - Previews
#Preview {
    AnimatablePreview()
}

private struct AnimatablePreview: View {

    @State private var direction: GameArrowView.Direction = .up

    private var state: GameArrowView.Statez {
        .init(
            direction: direction
        )
    }

    var body: some View {
        VStack {
            Picker("Direction", selection: $direction) {
                ForEach(GameArrowView.Direction.allCases) {
                    Text("\($0)".capitalized)
                }
            }
            .pickerStyle(.menu)

            GameArrowView(
                state: state
            )
            .padding()
            .background(.purple)
        }
    }
}
