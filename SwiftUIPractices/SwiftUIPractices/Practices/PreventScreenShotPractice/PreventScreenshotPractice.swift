//
//  PreventScreenshotPractice.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2026/02/17.
//  Learning from Kavsoft: https://youtu.be/il__Pi6gnz0?si=VlwGoWyOsg5e-jwK
//

import SwiftUI

// MARK: - Preview Screen

/// Demonstrates screenshot prevention by masking content with a secure text field layer.
/// Includes a toggle to enable/disable the protection at runtime.
struct PreventScreenshotPractice: View {
    @State private var preventScreenshotEnabled: Bool = true
    var body: some View {
        List {
            Text("Some Private Content")
            Text("Some other Private Content")
            Toggle("Prevent Screenshot", isOn: $preventScreenshotEnabled)
        }.navigationTitle("Screenshot Prevention")
            .preventScreenshot(enabled: preventScreenshotEnabled)
            .background(
                ContentUnavailableView(
                    "Screenshots not allowed",
                    systemImage: "iphone.slash",
                    description: Text("There are some contents in this screen that are not for public use.")
                )
            )
    }
}

// MARK: - View Modifier

extension View {
    /// Masks the view with a secure text field layer to prevent screenshot capture.
    /// When `enabled` is false, the view is masked with a plain rectangle (effectively no masking).
    @ViewBuilder
    func preventScreenshot(enabled: Bool = true) -> some View {
        mask(
            Group {
                if enabled {
                    ScreenshotPreventer()
                        .ignoresSafeArea()
                } else {
                    Rectangle()
                }
            }
        )
    }
}

// MARK: - UIViewRepresentable

/// Wraps a `UITextField` with `isSecureTextEntry = true` to leverage iOS's built-in
/// screenshot/recording protection. The secure text field's internal layer automatically
/// hides its content during screen capture, and we use it as a mask to protect the SwiftUI view.
struct ScreenshotPreventer: UIViewRepresentable {
    func makeUIView(context _: Context) -> UIView {
        let view = UITextField()
        view.isSecureTextEntry = true
        view.text = ""
        view.isUserInteractionEnabled = false
        // Find the internal auto-hidden layer and set its background to white
        // so it acts as a fully opaque mask for the protected content.
        if let autoHiddenLayer = findAutoHiddenLayer(view: view) {
            autoHiddenLayer.backgroundColor = UIColor.white.cgColor
        } else {
            view.layer.sublayers?.last?.backgroundColor = UIColor.white.cgColor
        }
        return view
    }

    func updateUIView(_: UIView, context _: Context) {}

    /// Searches for the internal `UITextLayoutCanvasView` layer that iOS uses
    /// to hide secure text field content during screenshots and screen recordings.
    func findAutoHiddenLayer(view: UIView) -> CALayer? {
        if let layers = view.layer.sublayers {
            if let layer = layers.first(
                where: { $0.delegate.debugDescription
                    .contains("UITextLayoutCanvasView")
                })
            {
                return layer
            }
        }
        return nil
    }
}

#Preview {
    PreventScreenshotPractice()
}
