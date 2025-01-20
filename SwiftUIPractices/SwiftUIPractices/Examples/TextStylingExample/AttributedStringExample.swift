//
//  AttributedStringExample.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/20.
//

import SwiftUI

struct AttributedStringExample: View {
    var attributedString1: AttributedString {
        var myString: AttributedString = "Attributed String"
        myString.foregroundColor = .orange
        myString.backgroundColor = .black
        myString.font = .caption.weight(.semibold)
        return myString
    }
    let colors: [Color] = [.red, .green, .blue, .yellow, .purple]
    let helloWorld = "Hello, World! This is a String"
    @State private var topIndex: Int = 0
    @State private var direction: Int = 1
    var attributedString2: AttributedString {
        var myString = AttributedString()
        myString.font = .caption.weight(.semibold)

        for (index, char) in helloWorld.enumerated() {
            var charString = AttributedString(String(char))
            let color = colors[index % colors.count]
            charString.foregroundColor = color
//            let j = Double(top - index)
//            charString.baselineOffset = -j * j * 0.1
            charString.baselineOffset = cos((.pi/2) * Double(index - topIndex)) * 5
            myString += charString
        }
        return myString
    }

    var animation: Animation {
        .linear(duration: 0.3)
        .repeatForever(autoreverses: true)
    }

    var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            Text(attributedString1)
            Text(attributedString2)
                .animation(animation)
                .onReceive(timer) { _ in
                    if topIndex == 0  {
                        direction = 1
                    } else if topIndex == helloWorld.count - 1 {
                        direction = -1
                    }
                    self.topIndex += 1 * direction
                }
        }
    }
}

#Preview {
    AttributedStringExample()
}
