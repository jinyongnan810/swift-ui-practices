//
//  CustomColorPickerPractice.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/16.
//

import SwiftUI

struct CustomColorPickerPractice: View {
    @State private var leftColor: Color = .blue
    @State private var centerColor: Color = .yellow
    @State private var rightColor: Color = .red
    var body: some View {
        ZStack {
            Color.cyan.ignoresSafeArea()
            VStack {
                HStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(leftColor)
                        .frame(width: 50, height: 50)
                    RoundedRectangle(cornerRadius: 10)
                        .fill(centerColor)
                        .frame(width: 50, height: 50)
                    RoundedRectangle(cornerRadius: 10)
                        .fill(rightColor)
                        .frame(width: 50, height: 50)
                }

                VStack {
                    MyColorPicker(label: "Left Square", color: $leftColor)
                    MyColorPicker(label: "Center Square", color: $centerColor)
                    MyColorPicker(label: "Right Square", color: $rightColor)

                }.padding()
            }
        }
    }
}

#Preview {
    CustomColorPickerPractice()
}
