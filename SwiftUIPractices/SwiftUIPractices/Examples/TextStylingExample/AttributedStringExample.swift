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
    var attributedString2: AttributedString {
        let helloWorld = "Hello, World! This is a String"
        var myString = AttributedString()
        myString.font = .caption.weight(.semibold)
        for (index, char) in helloWorld.enumerated() {
            var charString = AttributedString(String(char))
            let color = colors[index % colors.count]
            charString.foregroundColor = color
            let j = Double(helloWorld.count / 2 - index)
            charString.baselineOffset = -j * j * 0.1
            myString += charString
        }
        return myString
    }

    var body: some View {
        List {
            Text(attributedString1)
            Text(attributedString2)
        }
    }
}

#Preview {
    AttributedStringExample()
}
