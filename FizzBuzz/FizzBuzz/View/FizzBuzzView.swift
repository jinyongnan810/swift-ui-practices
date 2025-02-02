//
//  FizzBuzzView.swift
//  FizzBuzz
//
//  Created by Yuunan kin on 2025/02/02.
//

import SwiftUI

struct FizzBuzzView: View {
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(1 ... 100, id: \.self) { i in
                    let isFizz = i.isMultiple(of: 3)
                    let isBuzz = i.isMultiple(of: 5)
                    if isFizz, isBuzz {
                        MyTextView(text: "FizzBuzz")
                    } else if isFizz {
                        MyTextView(text: "Fizz")
                    } else if isBuzz {
                        MyTextView(text: "Buzz")
                    } else {
                        MyTextView(text: "\(i)")
                    }
                }
            }
        }
    }
}

#Preview {
    FizzBuzzView()
}
