//
//  ToggleView.swift
//  Alarm
//
//  Created by Yuunan kin on 2025/02/15.
//

import SwiftUI

struct ToggleView: View {
    @Binding var enabled: Bool
    var body: some View {
        Capsule()
            .frame(width: 70, height: 35)
            .foregroundStyle(enabled ? .myBlack : .myNickel)
            .overlay {
                ZStack {
                    HStack {
                        if enabled {
                            Text("ON")
                                .font(.footnote)
                                .foregroundStyle(.white)
                                .fixedSize()
                        }
                        Spacer()
                        if !enabled {
                            Text("OFF")
                                .font(.footnote)
                                .foregroundStyle(.myBlack)
                                .fixedSize()
                        }
                    }.padding(12)
                    Circle()
                        .foregroundStyle(.myLightGray)
                        .frame(width: 25)
                        .offset(x: enabled ? 17 : -17)
                        .gesture(DragGesture().onChanged { ges in
                            withAnimation {
                                enabled = ges.translation.width > 0
                            }
                        })
                }
            }
            .onTapGesture {
                withAnimation {
                    enabled.toggle()
                }
            }
    }
}

#Preview {
    VStack {
        ToggleView(enabled: .constant(true))
        ToggleView(enabled: .constant(false))
    }
}
