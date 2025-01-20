//
//  MySquaresRow.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/20.
//

import SwiftUI

struct MySquaresRow: View {
    var colors: [Color] = [.red, .blue, .green]
    var size: CGFloat = 50
    var body: some View {
        GridRow {
            ForEach(colors, id: \.self) { color in
                Rectangle()
                    .fill(color)
                    .frame(width: size, height: size)
                    .clipShape(.rect(cornerRadius: 5))
            }
        }
    }
}

#Preview {
    Grid {
        ForEach(0 ..< 5, id: \.self) { _ in
            MySquaresRow()
        }
    }
}
