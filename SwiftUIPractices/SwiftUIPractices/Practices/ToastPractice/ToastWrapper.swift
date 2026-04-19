//
//  ToastWrapper.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/26.
//

import SwiftUI

struct ToastWrapper<Content: View>: View {
    private let toastAnimation = Animation.spring(response: 0.45, dampingFraction: 0.88)
    private let replacementDelay: Duration = .milliseconds(180)
    @ViewBuilder private let content: Content
    @State private var currentToast: Toast?
    @State private var pendingToast: Toast?
    @State private var dismissTask: Task<Void, Never>?
    @State private var swapTask: Task<Void, Never>?

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            content

            GlassEffectContainer {
                if let currentToast {
                    PracticeToastView(
                        toast: currentToast,
                        dismissToast: dismissCurrentToast
                    )
                    .id(currentToast.id)
                    .transition(.offset(y: 30).combined(with: .opacity))
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .animation(toastAnimation, value: currentToast != nil)
        .environment(\.showToast, ShowToastAction(handler: show))
        .environment(\.dismissToast, DismissToastAction(handler: dismissCurrentToast))
        .onDisappear {
            dismissTask?.cancel()
            swapTask?.cancel()
        }
    }

    private func show(_ toast: Toast) {
        dismissTask?.cancel()
        swapTask?.cancel()

        guard currentToast != nil else {
            present(toast)
            return
        }

        pendingToast = toast

        withAnimation(toastAnimation) {
            currentToast = nil
        }

        swapTask = Task { @MainActor in
            try? await Task.sleep(for: replacementDelay)

            guard !Task.isCancelled, let pendingToast else { return }
            self.pendingToast = nil
            present(pendingToast)
        }
    }

    private func present(_ toast: Toast) {
        withAnimation(toastAnimation) {
            currentToast = toast
        }

        scheduleDismiss(for: toast)
    }

    private func scheduleDismiss(for toast: Toast) {
        dismissTask?.cancel()
        dismissTask = Task { @MainActor in
            try? await Task.sleep(for: toast.duration)

            guard !Task.isCancelled else { return }
            dismissCurrentToast()
        }
    }

    private func dismissCurrentToast() {
        dismissTask?.cancel()
        swapTask?.cancel()
        pendingToast = nil

        guard currentToast != nil else { return }

        withAnimation(toastAnimation) {
            currentToast = nil
        }
    }
}
