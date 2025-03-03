//
//  FooterView.swift
//  BodyShape
//
//  Created by Yuunan kin on 2025/03/03.
//

import SwiftUI

struct FooterView: View {
    @Binding var isPresented: Bool
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Your pan for March,2025")
                Spacer()
                NumberWithUnit {
                    Text("1.8")
                        .font(.title2)
                        .fontWeight(.bold)
                }
            }
            HeartRateView()
            ContinueButton(isPresented: $isPresented)
        }
    }
}

struct HeartRateView: View {
    var body: some View {
        HStack {
            HeartView()
            VStack {
                Text("Heart Rate").font(.title3).fontWeight(.semibold)
                Text("3 March 2025").font(.callout).foregroundStyle(.gray)
            }
            Spacer()
            NumberWithUnit(content: {
                Text("256").font(.title)
                    .fontWeight(.bold)
            }, unit: "bpm")
        }
    }
}

struct HeartView: View {
    var body: some View {
        ZStack {
            Image(systemName: "heart.fill")
                .imageScale(.large)
                .foregroundStyle(.black)
            Image(systemName: "bolt.horizontal.fill")
                .foregroundStyle(.lightGreen)
                .imageScale(.small)
                .offset(x: -5)
        }.padding()
            .background(Circle().fill(.lightGreen))
    }
}

struct ContinueButton: View {
    @Binding var isPresented: Bool
    var body: some View {
        Button(action: {
            withAnimation {
                isPresented = false
            }
        }) {
            Text("Continue").foregroundStyle(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 30).fill(.black))
        }
    }
}
