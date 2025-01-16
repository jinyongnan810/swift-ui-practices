//
//  BuyNowView.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/15.
//

import SwiftUI

struct BuyNowView: View {
    let price: Double
    let discount: Int?
    var priceAferDiscount: Double {
        if let discount {
            price - price * Double(discount) / 100
        } else {
            price
        }
    }

    let cornorRadius: CGFloat = 20

    var body: some View {
        ZStack {
            VStack {
                if discount != nil {
                    Text("\(discount!)% OFF!")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .padding()
                        .fontWeight(.semibold)
                        .background {
                            Color.blue.cornerRadius(cornorRadius)
                        }.rotationEffect(.degrees(-15))
                        .shadow(radius: 5)
                        .offset(y: -40)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }

                HStack {
                    Text("Buy Now")
                        .font(.largeTitle)
                        .fontWeight(.semibold)

                    Spacer()
                    HStack {
                        if discount != nil {
                            Text("$\(price, specifier: "%.2f")")
                                .strikethrough()
                                .foregroundStyle(.white)
                            Text("$\(priceAferDiscount, specifier: "%.2f")")
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                        } else {
                            Text("$\(price, specifier: "%.2f")")
                                .foregroundStyle(.white)
                        }
                    }
                }

            }.padding().background {
                ZStack {
                    Color.red.clipShape(.rect(cornerRadius: cornorRadius))
                    RoundedRectangle(cornerRadius: cornorRadius)
                        .stroke(.white)
                }
            }
        }
    }
}

#Preview {
    ZStack {
        Color.black.opacity(0.2)
        VStack {
            BuyNowView(price: 20, discount: 75)
            BuyNowView(price: 20, discount: nil)
        }
    }
}
