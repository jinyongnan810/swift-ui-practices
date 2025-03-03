//
//  ResultView.swift
//  BodyShape
//
//  Created by Yuunan kin on 2025/03/03.
//

import SwiftUI

struct ResultView: View {
    @Binding var isPresented: Bool
    var body: some View {
        VStack(spacing: 20) {
            HeaderView(isPresented: $isPresented)
            DailyAmountView()
            ActivityListView()
            FooterView(isPresented: $isPresented)
        }.padding()
    }
}

#Preview {
    ResultView(isPresented: .constant(true))
}
