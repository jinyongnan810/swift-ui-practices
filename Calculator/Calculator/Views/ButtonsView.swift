//
//  ButtonsView.swift
//  Calculator
//
//  Created by Yuunan kin on 2025/01/27.
//

import SwiftUI

struct ButtonsView: View {
    @Binding var computation: String
    @Binding var result: String
    var body: some View {
        Grid {
            GridRow {
                ActionButtonView(buttonType: .clear, color: .cyan)
                ActionButtonView(buttonType: .negative, color: .cyan)
                ActionButtonView(buttonType: .percent, color: .cyan)
                ActionButtonView(buttonType: .divide, color: .red)
            }
            GridRow {
                ActionButtonView(buttonType: .seven, color: .text)
                ActionButtonView(buttonType: .eight, color: .text)
                ActionButtonView(buttonType: .nine, color: .text)
                ActionButtonView(buttonType: .multiply, color: .red)
            }
            GridRow {
                ActionButtonView(buttonType: .four, color: .text)
                ActionButtonView(buttonType: .five, color: .text)
                ActionButtonView(buttonType: .six, color: .text)
                ActionButtonView(buttonType: .subtract, color: .red)
            }
            GridRow {
                ActionButtonView(buttonType: .one, color: .text)
                ActionButtonView(buttonType: .two, color: .text)
                ActionButtonView(buttonType: .three, color: .text)
                ActionButtonView(buttonType: .add, color: .red)
            }
            GridRow {
                ActionButtonView(buttonType: .undo, color: .text)
                ActionButtonView(buttonType: .zero, color: .text)
                ActionButtonView(buttonType: .decimal, color: .text)
                ActionButtonView(buttonType: .equal, color: .red)
            }
        }.background(RoundedRectangle(cornerRadius: 20).fill(
            Color.buttonsAreaBackground
        ))
    }
}

#Preview {
    ButtonsView(computation: .constant(""), result: .constant("0"))
}
