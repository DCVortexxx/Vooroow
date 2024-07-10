import SwiftUI

struct GameArrowView: View {

    // MARK: - Sub-types
    enum Constants {
        static let height = 150.0
    }

    enum Direction: CaseIterable, Identifiable {
        case up
        case left
        case right
        case down

        var id: Self { self }
    }

    enum Validation: CaseIterable, Identifiable {
        case none
        case failed
        case validated

        var id: Self { self }
    }

    struct Statez: Identifiable {
        let id: UUID
        let direction: Direction
        var validation: Validation
        let isTrap: Bool
    }

    // MARK: - State
    let state: Statez
    @State private var validationAnimation: Validation = .none

    // MARK: - View
    var body: some View {
        Image(arrow: state.direction)
            .font(.system(size: Constants.height))
            .shadow(radius: 1, x: 2, y: 2)
            .phaseAnimator(
                [false, true],
                content: { $0.scaleEffect(state.validation == .none && $1 ? 1 : 0.97) },
                animation: { _ in .linear(duration: 1) }
            )
            .animation(.bouncy) {
                $0
                    .foregroundStyle(state.foregroundStyle)
                    .offset(state.arrowOffset(for: validationAnimation))
            }
            .onChange(of: state.validation) {
                triggerAnimation(validation: $1)
            }
            .padding(30)
            .background(.arrowBackground.opacity(0.8))
            .clipShape(.circle)
    }

    private func triggerAnimation(validation: Validation) {
        switch validation {
        case .none:
            withAnimation(.none) {
                validationAnimation = .none
            }
        case .failed:
            validationAnimation = .failed
            withAnimation(.spring(response: 0.2, dampingFraction: 0.2, blendDuration: 0.2)) {
                validationAnimation = .none
            }
        case .validated:
            withAnimation(.easeIn(duration: 0.2)) {
                validationAnimation = .validated
            }
        }
    }

}

// MARK: - Public helpers
extension GameArrowView.Direction {

    var opposite: GameArrowView.Direction {
        switch self {
        case .up:       return .down
        case .left:     return .right
        case .right:    return .left
        case .down:     return .up
        }
    }

}

extension GameArrowView.Statez {

    var expectedDirection: GameArrowView.Direction {
        isTrap ? direction.opposite : direction
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

private extension GameArrowView.Statez {

    var foregroundStyle: Color {
        switch validation {
        case .validated:
            return .arrowValidated
        case .failed:
            return .arrowFailed
        case .none:
            return isTrap ? .arrowTrap : .arrowDefault
        }
    }

    func arrowOffset(for animation: GameArrowView.Validation) -> CGSize {
        switch animation {
        case .none:
            return .zero
        case .failed:
            return .init(width: 30, height: 0)
        case .validated:
            let outOfBounds = GameArrowView.Constants.height * 1.5
            switch expectedDirection {
            case .up:
                return .init(width: 0, height: -outOfBounds)
            case .left:
                return .init(width: -outOfBounds, height: 0)
            case .right:
                return .init(width: outOfBounds, height: 0)
            case .down:
                return .init(width: 0, height: outOfBounds)
            }
        }
    }

}

// MARK: - Previews
#Preview {
    AnimatablePreview()
}

private struct AnimatablePreview: View {

    @State private var direction: GameArrowView.Direction = .up
    @State private var validation: GameArrowView.Validation = .none
    @State private var isTrap: Bool = false

    private var state: GameArrowView.Statez {
        .init(
            id: .init(),
            direction: direction,
            validation: validation,
            isTrap: isTrap
        )
    }

    var body: some View {
        VStack {
            GameArrowView(
                state: state
            )
            .padding()
            .background(.purple)

            Spacer()

            Picker("Direction", selection: $direction) {
                ForEach(GameArrowView.Direction.allCases) {
                    Text("\($0)".capitalized)
                }
            }
            .pickerStyle(.segmented)

            Picker("Validation", selection: $validation) {
                ForEach(GameArrowView.Validation.allCases) {
                    Text("\($0)".capitalized)
                }
            }
            .pickerStyle(.segmented)

            Toggle("It's a trap", isOn: $isTrap)
        }
        .padding()
        .frame(maxHeight: 400)
    }
}
