//
//  MyColorPicker.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/16.
//

import SwiftUI

struct MyColorPicker: View {
    let label: String
    @Binding var color: Color
    let allColors: [Color] = [
        .red, .blue, .green, .yellow, .orange, .purple, .pink, .black, .white, .gray, .brown,
    ]
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.headline)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(allColors, id: \.self) { color in
                        Button(action: {
                            withAnimation {
                                self.color = color
                            }
                        }) {
                            Circle()
                                .fill(color)
                                .frame(width: 30, height: 30)
                                .scaleEffect(self.color == color ? 1.2 : 1)
                                .shadow(radius: self.color == color ? 5 : 0)
                        }
                    }
                }
                .padding()
            }.background(Color.gray.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 20))
//                .overlay {
//                    RoundedRectangle(cornerRadius: 20).stroke(Color.white)
//                }
        }
    }
}

#Preview {
    MyColorPicker(label: "test", color: .constant(.red))
}
