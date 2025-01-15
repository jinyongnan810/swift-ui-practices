//
//  PriceCardPractice.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/15.
//

import SwiftUI

struct PriceCardPractice: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.2).ignoresSafeArea()
            VStack(spacing: 20) {
                BuyNowView(price: 20, discount: 75)
                BuyNowView(price: 20, discount: nil)
            }.padding()
        }
    }
}

#Preview {
    PriceCardPractice()
}
