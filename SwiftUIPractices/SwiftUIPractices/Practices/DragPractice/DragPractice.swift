//
//  DragPractice.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/23.
//

import SwiftUI

struct DragPractice: View {
    @State private var datas: [[DragBlockData]] = [
        [.init(image: "star"), .init(image: "heart"), .init(image: "bell")],
        [.init(image: "bolt"), .init(image: "cloud"), .init(image: "person")],
        [.init(image: "leaf"), .init(image: "moon"), .init(image: "sun.max")],
    ]
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.cyan, .purple],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ).ignoresSafeArea()
            VStack {
                Text("Drag Above Me")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding()
                    .zIndex(100)
                Spacer()
                Grid {
                    ForEach(0 ..< datas.count, id: \.self) { i in
                        GridRow {
                            ForEach(0 ..< datas[i].count, id: \.self) { j in
                                DragBlock(data: $datas[i][j])
                            }
                        }
                    }
                }

                Spacer()

                Button {
                    withAnimation {
                        datas = datas.shuffled().map { row in
                            row.shuffled()
                        }
                    }
                } label: {
                    Text("Shuffle")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.black.gradient)
                        )
                }

            }.padding()
        }
        .onChange(of: datas) { _, newValue in
            print("⭐️")
            for row in newValue {
                print(row.map { data in
                    data.zIndex
                })
            }
        }
    }
}

#Preview {
    DragPractice()
}
