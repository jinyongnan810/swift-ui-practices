//
//  MySquares.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/20.
//

import SwiftUI

struct MySquares: View {
    var body: some View {
        Grid {
            MySquaresRow(colors: [.red, .green, .blue])
            MySquaresRow(colors: [.cyan, .yellow, .indigo])
            MySquaresRow(colors: [.pink, .orange, .purple])
        }
    }
}

#Preview {
    MySquares()
}
