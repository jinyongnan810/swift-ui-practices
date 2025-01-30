//
//  ActionButtonView.swift
//  Calculator
//
//  Created by Yuunan kin on 2025/01/27.
//

import SwiftUI

struct ActionButtonView: View {
    let buttonType: CalcButtonType
    let color: Color
    var buttonContent: AnyView {
        if buttonType.rawValue.contains("IMG") {
            let systemName = buttonType.rawValue.replacingOccurrences(of: "IMG_", with: "")
            return AnyView(Image(systemName: systemName))
        }
        return AnyView(Text(buttonType.rawValue))
    }

    let buttonDimension: CGFloat = isIpad ?
        UIScreen.main.bounds.width / 6 :
        UIScreen.main.bounds.width / 5

    var body: some View {
        buttonContent
            .foregroundStyle(color)
            .font(isIpad ? .largeTitle : .title)
            .fontWeight(isIpad ? .heavy : .semibold)
            .frame(width: buttonDimension, height: buttonDimension)
            .background(
                RoundedRectangle(cornerRadius: 12).fill(Color.buttonBacground)
            )
            .shadow(color: Color.text.opacity(0.06), radius: 2)
    }
}

#Preview {
    ActionButtonView(buttonType: .equal, color: .red)
}
