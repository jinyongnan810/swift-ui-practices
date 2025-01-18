//
//  LazyVGridExample.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/18.
//

import SwiftUI

struct LazyVGridExample: View {
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns) {
                ForEach(MoreImages.allCases, id: \.self) { img in
                    Image(img.rawValue)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(20)
                        .shadow(radius: 10)
                }
            }
            .padding()
        }
    }
}

#Preview {
    LazyVGridExample()
}
