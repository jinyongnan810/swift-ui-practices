//
//  SFSymbolsAnimation.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/19.
//

import SwiftUI

struct SFSymbolsAnimation: View {
    @State private var section1 = false
    @State private var pauseGlobe = false
    @State private var section2 = false
    @State private var section3 = false
    @State private var section4 = false
    @State private var section5 = false
    var body: some View {
        Form {
            Section("Enable and disable animations") {
                HStack {
                    Image(systemName: "globe")
                        .symbolEffectsRemoved(pauseGlobe)
                        .symbolEffect(.bounce, value: section1)
                    Image(systemName: "house.fill")
                        .symbolEffect(.pulse, value: section1)
                }

                Button(pauseGlobe ? "resume globe animation" : "pause globe animation") {
                    pauseGlobe.toggle()
                }
            }.onTapGesture {
                section1.toggle()
            }
            Section("iterative and cumulative") {
                HStack {
                    Image(systemName: "square.stack.3d.up")
                        .symbolEffect(.variableColor.iterative, value: section2)
                        .foregroundStyle(section2 ? .red : .black)
                    Image(systemName: "square.stack.3d.up")
                        .symbolEffect(.variableColor.cumulative, value: section2)
                        .foregroundStyle(section2 ? .blue : .black)
                }
            }.onTapGesture {
                section2.toggle()
            }
            Section("Transition") {
                HStack {
                    Image(systemName: section3 ? "eye" : "eye.slash")
                        .symbolEffect(.bounce, value: section3)
                        .foregroundStyle(section3 ? .blue : .black)
                    Image(systemName: section3 ? "eye" : "eye.slash")
                        .symbolEffect(.bounce, value: section3)
                        .foregroundStyle(section3 ? .blue : .black)
                        .contentTransition(.symbolEffect(.replace.byLayer.downUp))
                }
            }.onTapGesture {
                section3.toggle()
            }

            Section("Repeat and Speed") {
                HStack {
                    Image(systemName: section4 ? "person.crop.circle.badge.plus" : "bolt.horizontal.circle.fill")
                        .symbolEffect(
                            .pulse.wholeSymbol,
                            options: .repeat(3).speed(3), value: section4
                        )
                        .foregroundStyle(section4 ? .blue : .purple)
                }
            }
            .onTapGesture {
                section4.toggle()
            }

            Section("RenderingMode and direction") {
                HStack {
                    Image(systemName: "leaf.arrow.trianglehead.clockwise")
                        .symbolRenderingMode(.monochrome)
                        .symbolEffect(.wiggle, value: section5)
                    Image(systemName: "leaf.arrow.trianglehead.clockwise")
                        .symbolRenderingMode(.hierarchical)
                        .symbolEffect(.wiggle.forward.byLayer, value: section5)
                    Image(systemName: "leaf.arrow.trianglehead.clockwise")
                        .symbolRenderingMode(.multicolor)
                        .symbolEffect(.wiggle.down.byLayer, value: section5)
                    Image(systemName: "leaf.arrow.trianglehead.clockwise")
                        .symbolRenderingMode(.multicolor)
                        .symbolEffect(
                            .rotate.clockwise.byLayer,
                            value: section5
                        )
                    Image(systemName: "leaf.arrow.trianglehead.clockwise")
                        .symbolRenderingMode(.multicolor)
                        .symbolEffect(
                            .rotate.clockwise.wholeSymbol,
                            value: section5
                        )
                }
            }
            .onTapGesture {
                section5.toggle()
            }
        }
    }
}

#Preview {
    SFSymbolsAnimation()
}
