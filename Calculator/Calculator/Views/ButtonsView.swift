//
//  ButtonsView.swift
//  Calculator
//
//  Created by Yuunan kin on 2025/01/27.
//

import SwiftUI

struct CalcButtonModel: Identifiable {
    let id: UUID = .init()
    let type: CalcButtonType
    let color: Color
}

struct CalcButtonRowModel: Identifiable {
    let id: UUID = .init()
    let buttons: [CalcButtonModel]
}

struct ButtonsView: View {
    @Binding var computation: String
    @Binding var result: String

    let buttons: [CalcButtonRowModel] = [
        .init(buttons: [
            .init(type: .clear, color: .cyan),
            .init(type: .negative, color: .cyan),
            .init(type: .percent, color: .cyan),
            .init(type: .divide, color: .red),
        ]),
        .init(buttons: [
            .init(type: .seven, color: .text),
            .init(type: .eight, color: .text),
            .init(type: .nine, color: .text),
            .init(type: .multiply, color: .red),
        ]),
        .init(buttons: [
            .init(type: .four, color: .text),
            .init(type: .five, color: .text),
            .init(type: .six, color: .text),
            .init(type: .subtract, color: .red),
        ]),
        .init(buttons: [
            .init(type: .one, color: .text),
            .init(type: .two, color: .text),
            .init(type: .three, color: .text),
            .init(type: .add, color: .red),
        ]),
        .init(buttons: [
            .init(type: .undo, color: .text),
            .init(type: .zero, color: .text),
            .init(type: .decimal, color: .text),
            .init(type: .equal, color: .red),
        ]),
    ]

    private func handleButtonTap(_ buttonType: CalcButtonType) {
        switch buttonType {
        case .clear:
            computation = ""
            result = "0"
        case .add, .subtract, .multiply, .divide:
            if lastCharIsDigitOrPercent(str: computation) {
                computation += buttonType.rawValue
            }
        case .equal, .negative:
            if computation.isEmpty || lastCharIsAnOperator(
                str: computation
            ) {
                break
            }
            let sign = buttonType == .negative ? -1.0 : 1.0
            let calculationResult = formatResult(val: calculate() * sign)
            result = calculationResult

            if buttonType == .negative {
                computation = calculationResult
            }
        case .decimal:
            if computation.isEmpty {
                computation += "0."
                break
            }
            if !lastCharIsDigit(str: computation) {
                break
            }
            let splitByDecimalPoint = computation.split(separator: ".")
            if splitByDecimalPoint.count > 1 {
                if Int(splitByDecimalPoint.last!) != nil {
                    break
                }
            }
            computation += buttonType.rawValue
        case .percent:
            if lastCharIsDigit(str: computation) {
                computation += buttonType.rawValue
            }
        case .undo:
            computation = String(computation.dropLast())
        default:
            // 0...9
            computation += buttonType.rawValue
        }
    }

    private func calculate() -> Double {
        // regulations
        var workingComputation = computation
        workingComputation = computation.replacingOccurrences(of: "%", with: "*0.01")
        workingComputation = workingComputation
            .replacingOccurrences(
                of: CalcButtonType.multiply.rawValue,
                with: "*"
            )
        workingComputation = workingComputation
            .replacingOccurrences(
                of: CalcButtonType.divide.rawValue,
                with: "/"
            )
        if lastCharIsEqualTo(str: workingComputation, char: ".") {
            workingComputation += "0"
        }

        // calculate

        let expression = NSExpression(format: workingComputation)
        let value = expression.expressionValue(with: nil, context: nil) as? Double ?? 0
        return value
    }

    var body: some View {
        Grid {
            ForEach(buttons) { row in
                GridRow {
                    ForEach(row.buttons) { button in
                        Button {
                            handleButtonTap(button.type)
                        } label: {
                            ActionButtonView(buttonType: button.type,
                                             color: button.color)
                        }
                    }
                }
            }
        }.padding().background(
            Color.buttonsAreaBackground.cornerRadius(20)
        )
    }
}

#Preview {
    ButtonsView(computation: .constant(""), result: .constant("0"))
}
