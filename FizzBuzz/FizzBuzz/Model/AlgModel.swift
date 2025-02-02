//
//  AlgModel.swift
//  FizzBuzz
//
//  Created by Yuunan kin on 2025/02/02.
//
import Foundation

struct AlgModel: Identifiable {
    let id: UUID = .init()
    let name: String
    let commentCode: (String) -> String
    var imports: String = ""
    let boilerWrapper: (String) -> String
    let maxCountConstDef: String
    let loopWrapper: (String) -> String
    let printWrapper: (String) -> String
    let printIntWrapper: () -> String
    var equality: String = "=="
    var moduloSymbol: String = "%"
    let ifStatementWrapper: (String, String) -> String
    let elseIfStatementWrapper: (String, String) -> String
    let elseStatementWrapper: (String) -> String
    var fizzBuzzCode: String {
        let mod3 = "i \(moduloSymbol) 3 \(equality) 0"
        let printFizz = printWrapper("Fizz")
        let mod5 = "i \(moduloSymbol) 5 \(equality) 0"
        let printBuzz = printWrapper("Buzz")

        let mod15 = "i \(moduloSymbol) 15 \(equality) 0"
        let printFizzBuzz = printWrapper("FizzBuzz")

        let printInt = printIntWrapper()

        let code = """
                    \(ifStatementWrapper(mod15, printFizzBuzz))
                    \(elseIfStatementWrapper(mod5, printFizz.indent()))
                    \(elseIfStatementWrapper(mod3, printBuzz.indent()))
                    \(elseStatementWrapper(printInt.indent()))
        """
        let mainCode = """

        \(maxCountConstDef)
        \(loopWrapper(code))
        """

        let fullCode = """
        \(imports)
            \(commentCode("FizzBuzz in \(name)"))
                \(boilerWrapper(mainCode))
        """
        return fullCode
    }
}
