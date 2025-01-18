//
//  ScaleFitOrFill.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/18.
//

import SwiftUI

struct ScaleFitOrFill: View {
    @State var isFit: Bool = true
    var contentMode: ContentMode {
        isFit ? .fit : .fill
    }

    var body: some View {
        ZStack {
            Image(ImagesForExploreExample.imgPurpleLightening.rawValue)
                .resizable()
                .cornerRadius(20)
                .aspectRatio(contentMode: contentMode)
                .frame(
                    width: .infinity,
                    height: UIScreen.main.bounds.height * 0.30
                )

                .background(.red)
                .padding()
                .background(.blue)
                .onTapGesture {
                    isFit.toggle()
                }
            Text(isFit ? "Fit" : "Fill")
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    ScaleFitOrFill()
}
