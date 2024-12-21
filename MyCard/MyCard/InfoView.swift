//
//  InfoView.swift
//  MyCard
//
//  Created by Yuunan kin on 2024/12/21.
//

import SwiftUI
import UIKit

struct InfoView: View {
    let text: String
    let imageName: String
    @Binding var showToast: Bool
    var body: some View {
        ZStack {
            Color.white
                .frame(height: 50)
                .clipShape(.capsule)
                .overlay(
                    HStack {
                        Image(systemName: imageName)
                        Text(text).foregroundColor(.black)
                    }
                )
                .onTapGesture {
                    UIPasteboard.general.string = text
                    withAnimation {
                        showToast = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            showToast = false
                        }
                    }
                }
        }
        //        RoundedRectangle(cornerRadius: 25)
        //            .fill(.white)
        //            .frame(height: 50)
        //            .overlay(
        //                HStack {
        //                    Image(systemName: "envelope")
        //                    Text("yuunan.kin@gmail.com")
        //                }
        //            )
        
    }
}


#Preview(traits: .sizeThatFitsLayout) {
    InfoView(text: "Hello World", imageName: "globe", showToast: .constant(false))
}
