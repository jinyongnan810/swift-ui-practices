//
//  MyImageView.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/14.
//

import SwiftUI

struct MyImageView: View {
    let name: String
    let maxWidth: CGFloat?

    init(name: String, maxWidth: CGFloat? = nil) {
        self.name = name
        self.maxWidth = maxWidth
    }
    var body: some View {
        Image(name)
            .resizable()
            .scaledToFit()
            .clipShape(.rect(cornerRadius: 20))
            .padding()
            .frame(maxWidth: maxWidth)
    }
}

#Preview {
    MyImageView(name: images[0])
}
