//
//  DashBoardView.swift
//  BodyShape
//
//  Created by Yuunan kin on 2025/03/03.
//

import SwiftUI

struct DashBoardView: View {
    @State var showResultScreen: Bool = false
    var body: some View {
        ZStack {
            VStack {
                TopRightIcon()
                    .onTapGesture {
                        withAnimation {
                            showResultScreen = true
                        }
                    }
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
            .fullScreenCover(isPresented: $showResultScreen) {
                ResultView(isPresented: $showResultScreen)
            }
    }
}

#Preview {
    DashBoardView()
}
