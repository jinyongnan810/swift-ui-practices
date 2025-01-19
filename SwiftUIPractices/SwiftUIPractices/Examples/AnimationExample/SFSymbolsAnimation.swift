//
//  SFSymbolsAnimation.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/19.
//

import SwiftUI

struct SFSymbolsAnimation: View {
    @State private var clicked = false
    @State private var pauseGlobe = false
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .symbolEffectsRemoved(pauseGlobe)
                    .symbolEffect(.bounce, value: clicked)
                    .padding()
                Image(systemName: "house.fill")
                    .imageScale(.large)
                    .symbolEffect(.pulse, value: clicked)
                    .padding()
                Image(systemName: "square.stack.3d.up")
                    .imageScale(.large)
                    .symbolEffect(.variableColor.iterative, value: clicked)
                    .foregroundStyle(clicked ? .red : .black)
                    .padding()
                Image(systemName: "square.stack.3d.up")
                    .imageScale(.large)
                    .symbolEffect(.variableColor.cumulative, value: clicked)
                    .foregroundStyle(clicked ? .blue : .black)
                    .padding()
            }
            HStack {
                Image(systemName: clicked ? "eye" : "eye.slash")
                    .imageScale(.large)
                    .symbolEffect(.bounce, value: clicked)
                    .foregroundStyle(clicked ? .blue : .black)
                    .padding()
                Image(systemName: clicked ? "eye" : "eye.slash")
                    .imageScale(.large)
                    .symbolEffect(.bounce, value: clicked)
                    .foregroundStyle(clicked ? .blue : .black)
                    .contentTransition(.symbolEffect(.replace.byLayer.downUp))
                    .padding()
                Image(systemName: clicked ? "person.crop.circle.badge.plus" : "bolt.horizontal.circle.fill")
                    .imageScale(.large)
                    .symbolEffect(
                        .pulse.wholeSymbol,
                        options: .repeat(3).speed(3), value: clicked
                    )
                    .foregroundStyle(clicked ? .blue : .purple)
                    .padding()
            }
            HStack {
                Button {
                    clicked.toggle()
                } label: {
                    Text("animate")
                        .font(.headline)
                        .foregroundColor(.orange)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 20).fill(.black))
                }

                Button {
                    pauseGlobe.toggle()
                } label: {
                    Text(pauseGlobe ? "resume globe animation" : "pause globe animation")
                        .font(.headline)
                        .foregroundColor(pauseGlobe ? .cyan : .orange)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 20).fill(.black))
                }
            }
        }
    }
}

#Preview {
    SFSymbolsAnimation()
}
