//
//  Toast.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/26.
//

import SwiftUI

struct Toast: Identifiable {
    struct Action {
        let title: String
        let handler: () -> Void
    }

    let id = UUID()
    let text: String
    let systemIcon: String
    let action: Action?
    let duration: Duration

    init(
        text: String,
        systemIcon: String,
        action: Action? = nil,
        duration: Duration = .seconds(2)
    ) {
        self.text = text
        self.systemIcon = systemIcon
        self.action = action
        self.duration = duration
    }
}

struct ShowToastAction {
    private let handler: (Toast) -> Void

    init(handler: @escaping (Toast) -> Void = { _ in }) {
        self.handler = handler
    }

    func callAsFunction(_ toast: Toast) {
        handler(toast)
    }
}

struct DismissToastAction {
    private let handler: () -> Void

    init(handler: @escaping () -> Void = {}) {
        self.handler = handler
    }

    func callAsFunction() {
        handler()
    }
}

private struct ShowToastEnvironmentKey: EnvironmentKey {
    static let defaultValue = ShowToastAction()
}

private struct DismissToastEnvironmentKey: EnvironmentKey {
    static let defaultValue = DismissToastAction()
}

extension EnvironmentValues {
    var showToast: ShowToastAction {
        get { self[ShowToastEnvironmentKey.self] }
        set { self[ShowToastEnvironmentKey.self] = newValue }
    }

    var dismissToast: DismissToastAction {
        get { self[DismissToastEnvironmentKey.self] }
        set { self[DismissToastEnvironmentKey.self] = newValue }
    }
}
