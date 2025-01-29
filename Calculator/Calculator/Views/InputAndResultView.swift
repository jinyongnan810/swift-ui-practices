//
//  InputAndResultView.swift
//  Calculator
//
//  Created by Yuunan kin on 2025/01/27.
//

import SwiftUI

struct InputAndResultView: View {
    let computation: String
    let result: String
    var body: some View {
        VStack(alignment: .trailing) {
            HStack {
                Spacer()
                Text(computation)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .minimumScaleFactor(0.1)
                    .padding(.vertical)
            }
            HStack {
                Text(result)
                    .font(.title)
                    .fontWeight(.bold)
                    .minimumScaleFactor(0.1)
            }
        }
        .padding()
    }
}

#Preview {
    VStack {
        InputAndResultView(computation: "11 + 22 + 33", result: "66")
        InputAndResultView(computation: "111.11 + 222.22", result: "333.33")
    }
}
