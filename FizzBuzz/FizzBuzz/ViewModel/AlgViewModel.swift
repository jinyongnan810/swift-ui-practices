//
//  AlgViewModel.swift
//  FizzBuzz
//
//  Created by Yuunan kin on 2025/02/02.
//

import Observation

@Observable
class AlgViewModel {
    var models: [AlgModel] = []
    init() {
        models = [
            .init(
                name: "Swift",
                commentCode: { code in
                    "// \(code)"
                },
                boilerWrapper: { code in code },
                maxCountConstDef: "let MAX = 100",
                loopWrapper: { code in
                    """
                    for i in 1...MAX {
                       \(code.indent())
                        }
                    """
                },
                printWrapper: { str in
                    #"print("\#(str)\t", terminator: "")"#
                },
                printIntWrapper: {
                    #"print("\(i)\t", terminator: "")"#
                },
                ifStatementWrapper: { logic, code in
                    """
                    if \(logic) {
                       \(code)
                    }
                    """

                },
                elseIfStatementWrapper: { logic, code in
                    """
                    else if \(logic) {
                       \(code)
                        }
                    """
                },
                elseStatementWrapper: { code in
                    """
                    else {
                       \(code)
                        }
                    """
                }
            ),
            .init(
                name: "C",
                commentCode: { code in
                    "// \(code)"
                },
                imports: "#include <stdio.h>",
                boilerWrapper: { code in
                    """
                    int main() {
                      \(code)
                    }
                    """
                },
                maxCountConstDef: "#define MAX 100",
                loopWrapper: { code in
                    """
                    for( int i = 1; i <= MAX; i++ ) {
                       \(code)
                    }
                    """
                },
                printWrapper: { str in
                    #"printf("\#(str)\t");"#
                },
                printIntWrapper: {
                    #"printf("%d\t", i);"#
                },
                ifStatementWrapper: { logic, code in
                    """
                    if (\(logic)) {
                       \(code)
                    }
                    """

                },
                elseIfStatementWrapper: { logic, code in
                    """
                    else if (\(logic)) {
                       \(code)
                    }
                    """
                },
                elseStatementWrapper: { code in
                    """
                    else {
                       \(code)
                    }
                    """
                }
            ),
        ]
    }
}
