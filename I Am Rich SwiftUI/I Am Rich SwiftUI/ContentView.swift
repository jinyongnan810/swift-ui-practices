//
//  ContentView.swift
//  I Am Rich SwiftUI
//
//  Created by Yuunan kin on 2024/12/19.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(.systemTeal).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/ .all/*@END_MENU_TOKEN@*/)
            VStack {
                Image("diamond")
                    .frame(width: 200.0, height: 200.0).padding(/*@START_MENU_TOKEN@*/ .all/*@END_MENU_TOKEN@*/)
                Text("I Am Rich").font(.largeTitle).fontWeight(.bold).foregroundColor(Color.white)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
