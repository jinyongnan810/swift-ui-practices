//
//  MyToastView.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/26.
//

import SwiftUI

struct PracticeToastView: View {
    let toast: Toast
    let dismissToast: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: toast.systemIcon)
                .font(.title3.weight(.semibold))
                .foregroundStyle(.primary)

            Text(toast.text)
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.primary)
                .lineLimit(2)
                .frame(maxWidth: .infinity, alignment: .leading)

            if let action = toast.action {
                Button(action.title) {
                    dismissToast()
                    action.handler()
                }
                .buttonStyle(.glass(.regular.interactive()))
                .font(.subheadline.weight(.semibold))
            }
        }
        .padding(.leading, 18)
        .padding(.trailing, toast.action == nil ? 18 : 12)
        .padding(.vertical, 14)
        .frame(maxWidth: .infinity)
        .glassEffect(.regular.interactive(), in: Capsule())
        .shadow(color: .black.opacity(0.12), radius: 18, y: 8)
//        .transition(.offset(y: 40).combined(with: .opacity))
    }
}

#Preview {
    ZStack(alignment: .bottom) {
        Color.gray.opacity(0.2)
            .ignoresSafeArea()

        PracticeToastView(
            toast: Toast(
                text: "Added to cart",
                systemIcon: "checkmark.circle.fill",
                action: .init(title: "Undo") {}
            ),
            dismissToast: {}
        )
        .padding()
    }
}
