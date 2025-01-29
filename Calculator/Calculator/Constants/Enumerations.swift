
import Foundation

enum Operation {
    case add, subtract, multiply, divide, equal, none
}

enum CalcButtonType: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "÷"
    case multiply = "×"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "IMG_plus.forwardslash.minus"
    case undo = "IMG_arrow.counterclockwise"
}

let enumOperators: [CalcButtonType] = [.subtract, .add, .divide, .multiply]

let multiplySymbol: String = CalcButtonType.multiply.rawValue
let divisionSymbol: String = CalcButtonType.divide.rawValue

let operators: String = "+-\(multiplySymbol)\(divisionSymbol)"
