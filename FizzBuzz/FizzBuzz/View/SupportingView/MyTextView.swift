//
//  MyTextView.swift
//  FizzBuzz
//
//  Created by Yuunan kin on 2025/02/02.
//

import SwiftUI

struct MyTextView: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.headline)
            .fontWeight(.semibold)
            .padding(.bottom)
    }
}

#Preview {
    MyTextView(text: "FizzBuzz")
}
