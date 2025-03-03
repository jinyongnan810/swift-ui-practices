//
//  HeaderView.swift
//  BodyShape
//
//  Created by Yuunan kin on 2025/03/03.
//

import SwiftUI

struct HeaderView: View {
    @Binding var isPresented: Bool
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Result")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("March 2025")
                    .foregroundStyle(.gray)
            }
            Spacer()
            Image(systemName: "return")
                .foregroundStyle(.white)
                .padding()
                .background(Circle().fill(.black))
                .onTapGesture {
                    withAnimation {
                        isPresented = false
                    }
                }
        }
    }
}
