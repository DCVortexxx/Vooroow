import SwiftUI

struct GameArrowListView: View {

    // MARK: - Sub-types
    struct Statez {
        let emphasized: GameArrowView.Statez.ID
        let arrows: [GameArrowView.Statez]
    }

    // MARK: - State
    let state: Statez

    // MARK: -  Actions
    let onSwipe: (GameArrowView.Direction) -> Void

    // MARK: - View
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                arrowsView
            }
            .onChange(of: state.emphasized) {
                onEmphasizeChanged($1, proxy: proxy)
            }
        }
        .scrollIndicators(.hidden)
        .scrollDisabled(true)
        .scrollClipDisabled()
        .frame(height: GameArrowView.Constants.height * 3)
        .gesture(
            DragGesture(minimumDistance: 20, coordinateSpace: .local)
                .onEnded(onDragEnd)
        )
    }

    @ViewBuilder
    private var arrowsView: some View {
        LazyVStack(spacing: 80) {
            centeringSpacer
            arrowContentViews
            centeringSpacer
        }
    }

    @ViewBuilder
    private var arrowContentViews: some View {
        ForEach(state.arrows) { i in
            GameArrowView(state: i)
                .scrollTransition { content, phase in
                    content
                        .opacity(phase.isIdentity ? 1 : 0.8)
                        .scaleEffect(phase.isIdentity ? 1 : 0.8)
                        .blur(radius: phase.isIdentity ? 0 : 10)
                }
        }
    }

    @ViewBuilder
    private var centeringSpacer: some View {
        Spacer()
            .frame(height: GameArrowView.Constants.height * 0.5)
    }

    // MARK: - Actions
    private func onDragEnd(_ value: DragGesture.Value) {
        let direction: GameArrowView.Direction = {
            let horizontalAmount = value.translation.width
            let verticalAmount = value.translation.height

            if abs(horizontalAmount) > abs(verticalAmount) {
                return horizontalAmount < 0 ? .left : .right
            } else {
                return verticalAmount < 0 ? .up : .down
            }
        }()

        onSwipe(direction)
    }

    private func onEmphasizeChanged(_ id: GameArrowView.Statez.ID, proxy: ScrollViewProxy) {
        withAnimation {
            proxy.scrollTo(id, anchor: .center)
        }
    }
}

// MARK: - Private helpers

// MARK: - Previews
#Preview {
    GameArrowListView(
        state: .init(
            emphasized: .init(),
            arrows: [
                .init(
                    id: .init(),
                    direction: .up,
                    validation: .none,
                    isTrap: false
                ),
                .init(
                    id: .init(),
                    direction: .down,
                    validation: .none,
                    isTrap: true
                ),
                .init(
                    id: .init(),
                    direction: .down,
                    validation: .none,
                    isTrap: false
                ),
                .init(
                    id: .init(),
                    direction: .right,
                    validation: .none,
                    isTrap: false
                ),
                .init(
                    id: .init(),
                    direction: .left,
                    validation: .none,
                    isTrap: false
                ),
                .init(
                    id: .init(),
                    direction: .up,
                    validation: .none,
                    isTrap: false
                ),
                .init(
                    id: .init(),
                    direction: .left,
                    validation: .none,
                    isTrap: true
                ),
                .init(
                    id: .init(),
                    direction: .right,
                    validation: .none,
                    isTrap: true
                ),
                .init(
                    id: .init(),
                    direction: .down,
                    validation: .none,
                    isTrap: false
                ),
            ]
        ),
        onSwipe: { _ in }
    )

}
