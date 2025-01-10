//
//  TitleView.swift
//  Greetings
//
//  Created by Yuunan kin on 2025/01/10.
//

import SwiftUI

struct TitleView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Greetings")
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text("Explore SwiftUI")
                .font(.headline)
                .fontWeight(.light)
        }
    }
}

#Preview {
    TitleView()
}
