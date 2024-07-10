import SwiftUI

@MainActor
struct GameArrowView: View {

    // MARK: - Sub-types
    enum Constants {
        static let content = 120.0
        static let padding = 30.0
        static var height: CGFloat { content + padding }
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
        case pending
        case failed
        case validated

        var id: Self { self }
    }

    struct Statez: Identifiable {
        let id: UUID
        let direction: Direction
        var validation: Validation
        let isTrap: Bool
        let decisionDuration: TimeInterval
    }

    // MARK: - State
    let state: Statez
    @State private var validationAnimation: Validation = .none
    @State private var durationAnimation: Double = 1.0

    // MARK: - View
    var body: some View {
        Image(arrow: state.direction)
            .font(.system(size: Constants.content - Constants.padding))
            .shadow(radius: 1, x: 2, y: 2)
            .phaseAnimator(
                [false, true],
                content: { $0.scaleEffect(state.validation == .pending && $1 ? 1 : 0.97) },
                animation: { _ in .linear(duration: 1) }
            )
            .animation(.bouncy) {
                $0
                    .foregroundStyle(state.foregroundStyle)
                    .offset(state.arrowOffset(for: validationAnimation))
            }
            .onChange(of: state.validation, initial: true) {
                triggerAnimation(validation: $1)
            }
            .sensoryFeedback(trigger: state.validation) {
                switch $1 {
                case .none, .pending:   return .none
                case .failed:           return .error
                case .validated:        return .selection
                }
            }
            .padding(Constants.padding)
            .background(background)
            .clipShape(.circle.inset(by: -4))
    }

    @ViewBuilder
    private var background: some View {
        ZStack {
            Circle()
                .fill(.arrowBackground)

            Circle()
                .inset(by: -2)
                .trim(from: 0, to: validationAnimation == .pending ? 0 : 1)
                .stroke(
                    .arrowDefault,
                    style: .init(
                        lineWidth: 4,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.none) {
                    $0.opacity(validationAnimation == .pending ? 1 : 0)
                }
        }
    }

    private func triggerAnimation(validation: Validation) {
        switch validation {
        case .none:
            validationAnimation = .none
        case .pending:
            withAnimation(.linear(duration: state.decisionDuration)) {
                validationAnimation = .pending
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
        case .none, .pending:
            return isTrap ? .arrowTrap : .arrowDefault
        }
    }

    func arrowOffset(for animation: GameArrowView.Validation) -> CGSize {
        switch animation {
        case .none, .pending:
            return .zero
        case .failed:
            return .init(width: 30, height: 0)
        case .validated:
            switch expectedDirection {
            case .up:
                return .init(width: 0, height: -GameArrowView.Constants.height)
            case .left:
                return .init(width: -GameArrowView.Constants.height, height: 0)
            case .right:
                return .init(width: GameArrowView.Constants.height, height: 0)
            case .down:
                return .init(width: 0, height: GameArrowView.Constants.height)
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
    @State private var decisionDuration: TimeInterval = 5

    private var state: GameArrowView.Statez {
        .init(
            id: .init(),
            direction: direction,
            validation: validation,
            isTrap: isTrap,
            decisionDuration: decisionDuration
        )
    }

    var body: some View {
        VStack {
            GameArrowView(
                state: state
            )
            .padding()
            .background(.gameBackground)

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

            VStack {
                LabeledContent("Decision duration", value: decisionDuration.formatted())
                Slider(
                    value: $decisionDuration,
                    in: 1...20,
                    step: 1
                )
            }
        }
        .padding()
        .frame(maxHeight: 400)
    }
}
