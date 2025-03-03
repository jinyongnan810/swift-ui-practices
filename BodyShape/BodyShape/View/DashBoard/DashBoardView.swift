//
//  DashBoardView.swift
//  BodyShape
//
//  Created by Yuunan kin on 2025/03/03.
//

import SwiftUI

struct DashBoardView: View {
    var body: some View {
        ZStack {
            VStack {
                TopRightIcon()
                Spacer()
                WelcomeView()
                    .padding(.vertical)
                WeightView()
                    .padding(.vertical)
                DataSummariesView()
                Spacer()
                ButtonsView()
            }
        }.padding(.horizontal)
    }
}

#Preview {
    DashBoardView()
}
