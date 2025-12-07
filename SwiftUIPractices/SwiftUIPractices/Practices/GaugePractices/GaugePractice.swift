//
//  GaugePractice.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/04/19.
//

import SwiftUI

struct GaugePractice: View {
    @State var value: Double = 40
    var body: some View {
        List {
            Section("Customized Gauge") {
                VStack {
                    HStack {
                        Spacer()
                        MyGauge(value: value)
                            .gaugeStyle(.accessoryCircularCapacity)
                        Spacer()
                        MyGauge(value: value)
                            .gaugeStyle(.accessoryCircular)
                        Spacer()
                    }.padding()
                    MyGauge(value: value)
                        .gaugeStyle(.accessoryLinear)
                        .padding(.vertical)
                    MyGauge(value: value)
                        .gaugeStyle(.accessoryLinearCapacity)
                        .padding(.vertical)
                    MyGauge(value: value)
                        .gaugeStyle(.linearCapacity)
                    Spacer()
                }
                Slider(value: $value, in: 0 ... 100)
            }
        }
    }
}

struct MyGauge: View {
    var value: Double = 0
    var body: some View {
        Gauge(value: value, in: 0 ... 100) {
            Text("Temp")
        } currentValueLabel: {
            Text("\(Int(value))°")
                .font(.title2)
                .bold()
        } minimumValueLabel: {
            Text("0°")
        } maximumValueLabel: {
            Text("100°")
        }.tint(value < 33 ? .blue : value < 66 ? .yellow : .red)
            .animation(.linear(duration: 0.3), value: value)
    }
}

#Preview {
    GaugePractice()
}
