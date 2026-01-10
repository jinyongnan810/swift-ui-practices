//
//  SheetWithHeightPractice.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/03/15.
//

import SwiftUI

struct SheetWithHeightPractice: View {
    @State private var showSheet = false
    @State private var sheetHeight: CGFloat = .zero
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.blue, .purple],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ).ignoresSafeArea()
            Button(action: {
                withAnimation {
                    showSheet = true
                }
            }) {
                Text("Display Sheet")
                    .foregroundStyle(.white)
            }
        }
        .sheet(isPresented: $showSheet) {
            ZStack {
                LinearGradient(
                    colors: [.red, .orange, .black],
                    startPoint: .top,
                    endPoint: .bottom
                ).opacity(0.5)
                    .ignoresSafeArea()
                VStack {
                    HStack {
                        Button(action: {
                            withAnimation {
                                showSheet = false
                            }
                        }) {
                            Text("Cancel")
                        }.padding()
                        Spacer()
                        Button(action: {
                            withAnimation {
                                showSheet = false
                            }
                        }) {
                            Text("OK")
                        }.padding()
                    }
                    Image("imgRoad")
                        .resizable()
                        .scaledToFit()
                        .clipShape(.rect(cornerRadius: 12))
                }
                .padding()
                .fixedSize(horizontal: false, vertical: true)
                .modifier(GetHeightModifier(height: $sheetHeight))
            }
            .presentationDetents([.height(sheetHeight)])
            //            .presentationDetents([.fraction(0.8)])
        }
    }
}

struct GetHeightModifier: ViewModifier {
    @Binding var height: CGFloat

    func body(content: Content) -> some View {
        content.background(
            GeometryReader { geo -> Color in
                DispatchQueue.main.async {
                    height = geo.size.height
                }
                return Color.clear
            }
        )
    }
}

#Preview {
    SheetWithHeightPractice()
}
