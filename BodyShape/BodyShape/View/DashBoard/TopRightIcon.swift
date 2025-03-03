//
//  TopRightIcon.swift
//  BodyShape
//
//  Created by Yuunan kin on 2025/03/03.
//

import SwiftUI

struct TopRightIcon: View {
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: "circle.grid.cross.fill")
                .foregroundStyle(.white)
                .imageScale(.large)
                .rotation3DEffect(.degrees(45), axis: (x: 0, y: 0, z: 1))
                .padding()
                .background(.black)
                .clipShape(Circle())
        }
    }
}

#Preview {
    TopRightIcon()
}
