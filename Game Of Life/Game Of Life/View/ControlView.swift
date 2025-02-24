//
//  ControlView.swift
//  Game Of Life
//
//  Created by Yuunan kin on 2025/02/24.
//

import SwiftUI

struct ControlView: View {
    @Binding var type: DesignType
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(
                    DesignType.allCases.reversed(),
                    id: \.rawValue
                ) { type in
                    Button(action: {
                        withAnimation {
                            self.type = type
                        }
                    }) {
                        Text(type.rawValue).font(.title)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(self.type == type ? Color.blue : Color.gray)
                            )
                            .shadow(radius: 3, x: 0, y: 3)
                    }
                }
            }.padding()
        }
    }
}
