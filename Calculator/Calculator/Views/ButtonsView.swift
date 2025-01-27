//
//  ButtonsView.swift
//  Calculator
//
//  Created by Yuunan kin on 2025/01/27.
//

import SwiftUI

struct ButtonsView: View {
    var body: some View {
        Grid {
            GridRow {
                ActionButtonView(text: "AC", color: .cyan)
                ActionButtonView(text: "+/-", color: .cyan)
                ActionButtonView(text: "%", color: .cyan)
                ActionButtonView(text: "divide", color: .red)
            }
            GridRow {
                ActionButtonView(text: "7", color: .black)
                ActionButtonView(text: "8", color: .black)
                ActionButtonView(text: "9", color: .black)
                ActionButtonView(text: "x", color: .red)
            }
            GridRow {
                ActionButtonView(text: "4", color: .black)
                ActionButtonView(text: "5", color: .black)
                ActionButtonView(text: "6", color: .black)
                ActionButtonView(text: "-", color: .red)
            }
            GridRow {
                ActionButtonView(text: "1", color: .black)
                ActionButtonView(text: "2", color: .black)
                ActionButtonView(text: "3", color: .black)
                ActionButtonView(text: "+", color: .red)
            }
            GridRow {
                ActionButtonView(text: "refresh", color: .black)
                ActionButtonView(text: "0", color: .black)
                ActionButtonView(text: ".", color: .black)
                ActionButtonView(text: "=", color: .red)
            }
        }.background(RoundedRectangle(cornerRadius: 20).fill(
            Color.buttonsAreaBackground
        ))
    }
}

#Preview {
    ButtonsView()
}
