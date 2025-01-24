//
//  CustomToolTipPractice.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/24.
//

import SwiftUI

struct CustomToolTipPractice: View {
    var body: some View {
        CustomToolTipView {
            Image(MoreImages.img1.rawValue)
                .resizable()
                .clipShape(.rect(cornerRadius: 20))
                .padding()
        } message: {
            ToolTipMessageView(text: "Thunder in desert")
        }
    }
}

#Preview {
    CustomToolTipPractice()
}
