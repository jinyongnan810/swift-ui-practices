//
//  ToastPractice.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/26.
//  Learning from Kavsoft: https://youtu.be/hR3qhzcrAE8?si=IC3xnnd4yL7FhB0N
//

import SwiftUI

struct ToastPractice: View {
    var body: some View {
        ToastWrapper {
            ToastPracticeContent()
        }
    }
}

private struct ToastPracticeContent: View {
    @State private var cartCount: Int = 0
    @Environment(\.showToast) private var showToast
    @Environment(\.dismissToast) private var dismissToast

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            VStack(spacing: 8) {
                Text("Toast Notifications")
                    .font(.largeTitle.bold())

                Text("Cart items: \(cartCount)")
                    .font(.headline)
                    .foregroundStyle(.secondary)
            }

            VStack(spacing: 14) {
                Button("Add To Cart") {
                    cartCount += 1

                    showToast(
                        Toast(
                            text: "Added to cart",
                            systemIcon: "checkmark.circle.fill",
                            action: .init(title: "Undo") {
                                guard cartCount > 0 else { return }
                                cartCount -= 1
                                showToast(
                                    Toast(
                                        text: "Undo completed",
                                        systemIcon: "arrow.uturn.backward.circle.fill"
                                    )
                                )
                            },
                            duration: .seconds(3)
                        )
                    )
                }
                .buttonStyle(.borderedProminent)

                Button("Show Notification") {
                    showToast(
                        Toast(
                            text: "A normal notification arrived",
                            systemIcon: "bell.badge.fill"
                        )
                    )
                }
                .buttonStyle(.bordered)

                Button("Dismiss Current Toast") {
                    dismissToast()
                }
                .buttonStyle(.bordered)
            }

            Spacer()
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    ToastPractice()
}
