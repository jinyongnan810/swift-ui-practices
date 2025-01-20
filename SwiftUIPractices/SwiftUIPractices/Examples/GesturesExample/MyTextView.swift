//
//  MyTextView.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/20.
//

import SwiftUI

struct MyTextView: View {
    var text: String = "Hello, World!"
    var body: some View {
        Text(text)
            .font(.title)
            .fontWeight(.semibold)
            .foregroundStyle(.orange)
            .padding()
            .background(.black)
            .clipShape(.rect(cornerRadius: 20))
    }
}

#Preview {
    MyTextView()
}
