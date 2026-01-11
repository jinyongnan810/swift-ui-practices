//
//  DynamicIslandToast.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2026/01/11.
//

import Observation
import SwiftUI

struct DynamicIslandToast: View {
    @State private var isPresented: Bool = false
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.cyan, .blue, .purple],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ).ignoresSafeArea()
            VStack {
                Button {
                    isPresented.toggle()
                } label: {
                    Text(isPresented ? "Hide Toast" : "Show Toast")
                }.buttonStyle(.glass)
            }.onChange(of: isPresented) { _, _ in
//                if newValue {
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                        isPresented = false
//                    }
//                }
            }

        }.navigationTitle("Dynamic Island Toast")
            .toolbarTitleDisplayMode(.inline)
            .dynamicIslandToast(isPresented: $isPresented, text: "Hello World!")
    }
}

extension View {
    @ViewBuilder
    func dynamicIslandToast(isPresented: Binding<Bool>, text: String) -> some View {
        modifier(DynamicIslandToastViewModifier(isPresented: isPresented, text: text))
    }
}

struct DynamicIslandToastViewModifier: ViewModifier {
    @Binding var isPresented: Bool
    var text: String

    @State private var overlayWindow: PassthroughWindow?
    @State private var overlayController: CustomHostingView?

    func body(content: Content) -> some View {
        content.background(WindowExtractor(getResult: { window in
            createOverlayWindow(window)
        }))
        .onChange(of: isPresented, initial: true) { _, newValue in
            guard let overlayWindow else { return }
            if newValue {
                overlayWindow.text = text
            }
            overlayWindow.isPresented = newValue
            overlayController?.isStatusBarHidden = newValue
        }
        .onChange(of: overlayWindow?.isPresented) { _, newValue in
            if let newValue, let _ = overlayWindow, newValue != isPresented {
                isPresented = newValue
            }
        }
    }

    func createOverlayWindow(_ window: UIWindow) {
        guard let windowScene = window.windowScene else {
            return
        }
        if let window = windowScene.windows.first(
            where: { $0.tag == 1009
            }) as? PassthroughWindow
        {
            overlayWindow = window
            overlayController = window.rootViewController as? CustomHostingView
        } else {
            let overlayWindow = PassthroughWindow(windowScene: windowScene)
            overlayWindow.backgroundColor = .clear
            overlayWindow.isHidden = false
            overlayWindow.isUserInteractionEnabled = true
            createRootController(overlayWindow)

            self.overlayWindow = overlayWindow
        }
    }

    func createRootController(_ window: PassthroughWindow) {
        let hostingController = CustomHostingView(rootView: ToastView(window: window))
        hostingController.view.backgroundColor = .clear
        window.rootViewController = hostingController
        overlayController = hostingController
    }
}

struct ToastView: View {
    var window: PassthroughWindow
    var isExpanded: Bool {
        window.isPresented
    }

    var body: some View {
        GeometryReader { geo in
            let safeArea = geo.safeAreaInsets
            let size = geo.size

            let hasDynamicIsland = safeArea.top >= 59

            // Initial sizes
            let dynamicIslandWidth: CGFloat = 120
            let dynamicIslandHeight: CGFloat = 36
            let offset: CGFloat = 11 + max(safeArea.top - 59, 0)

            // Expaned sizes
            let expandedWidth: CGFloat = size.width - 20
            let expandedHeight: CGFloat = 90
            let scaleX: CGFloat = isExpanded ? 1 : dynamicIslandWidth / expandedWidth
            let scaleY: CGFloat = isExpanded ? 1 : dynamicIslandHeight / expandedHeight

            ZStack {
                ConcentricRectangle(
                    corners: .concentric(minimum: .fixed(30)),
                    isUniform: true
                ).fill(.black).overlay {
                    ToastContent(hasDynamicIsland: hasDynamicIsland)
                        .frame(
                            width: expandedWidth,
                            height: expandedHeight,
                        )
                        .scaleEffect(x: scaleX, y: scaleY)
                }.frame(
                    width: isExpanded ? expandedWidth : dynamicIslandWidth,
                    height: isExpanded ? expandedHeight : dynamicIslandHeight
                )
                .offset(
                    y: hasDynamicIsland ? offset : (isExpanded ? safeArea.top + 10 : -80)
                )
                .opacity(hasDynamicIsland ? 1 : (isExpanded ? 1 : 0))
                .animation(.linear(duration: 0.2).delay(isExpanded ? 0 : 0.30)) { content in
                    content.opacity(hasDynamicIsland ? 1 : (isExpanded ? 1 : 0))
                }.geometryGroup()
                .contentShape(.rect)
                .gesture(DragGesture().onEnded { value in
                    if value.translation.height < 0 {
                        window.isPresented = false
                    }
                })
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .ignoresSafeArea()
                .animation(
                    .bouncy(duration: 0.3, extraBounce: 0),
                    value: isExpanded
                )
        }
    }

    @ViewBuilder
    func ToastContent(hasDynamicIsland: Bool) -> some View {
        if let text = window.text {
            HStack(spacing: 10) {
                Image(systemName: "checkmark.circle")
                    .foregroundStyle(.green)
                    .symbolEffect(
                        .wiggle,
                        options: .repeat(3),
                        value: isExpanded
                    )
                    .font(.largeTitle)
                VStack(alignment: .leading, spacing: 4) {
                    if hasDynamicIsland {
                        Spacer(minLength: 0)
                    }
                    Text(text).font(.largeTitle).foregroundStyle(.white)
                }.frame(width: .infinity, alignment: .leading)
                    .padding(.bottom, hasDynamicIsland ? 12 : 0)
                    .lineLimit(1)
            }
            .padding(.horizontal, 20)
            .compositingGroup()
            .blur(radius: isExpanded ? 0 : 10)
            .opacity(isExpanded ? 1 : 0)
        } else {
            Text("No Text?").foregroundStyle(.white)
        }
    }
}

struct WindowExtractor: UIViewRepresentable {
    var getResult: (UIWindow) -> Void
    func makeUIView(context _: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = .clear
        DispatchQueue.main.async {
            if let window = view.window {
                getResult(window)
            }
        }
        return view
    }

    func updateUIView(_: UIViewType, context _: Context) {}
}

@Observable
class PassthroughWindow: UIWindow {
    var text: String? = nil
    var isPresented: Bool = false
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let hitView = super.hitTest(point, with: event), let rootView = rootViewController?.view else {
            return nil
        }
        if #available(iOS 26, *) {
            if rootView.layer.hitTest(point)?.name == nil {
                return rootView
            }
            return nil
        } else {
            if #unavailable(iOS 18) {
                return hitView == rootView ? nil : hitView
            } else {
                for subView in rootView.subviews.reversed() {
                    let pointInSubView = subView.convert(point, from: rootView)
                    if subView.hitTest(pointInSubView, with: event) != nil {
                        return hitView
                    }
                }
                return nil
            }
        }
    }
}

class CustomHostingView: UIHostingController<ToastView> {
    var isStatusBarHidden: Bool = false {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }

    override var prefersStatusBarHidden: Bool {
        isStatusBarHidden
    }
}

#Preview {
    NavigationStack {
        DynamicIslandToast()
    }
}
