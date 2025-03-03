//
//  ProgressBarView.swift
//  BodyShape
//
//  Created by Yuunan kin on 2025/03/03.
//

import SwiftUI

struct ProgressBarView: View {
    var progress: Double
    let height: CGFloat = 8
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.black)

                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.lightGreen)
                    .frame(
                        width: geo.size.width * progress,
                        alignment: .leading
                    )
            }

        }.frame(width: .infinity, height: height)
    }
}
