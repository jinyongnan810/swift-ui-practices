//
//  DailyAmountView.swift
//  BodyShape
//
//  Created by Yuunan kin on 2025/03/03.
//

import SwiftUI

struct DailyDataModel: Identifiable {
    let id = UUID()
    let day: String
    let percentage: CGFloat
    let amount: Int
}

let data: [DailyDataModel] = [
    .init(
        day: "Mon",
        percentage: 0.6,
        amount: 1
    ),
    .init(
        day: "Tue",
        percentage: 0.3,
        amount: 5
    ),
    .init(
        day: "Wed",
        percentage: 0.5,
        amount: 8
    ),
    .init(
        day: "Thu",
        percentage: 1.0,
        amount: 12
    ),
    .init(
        day: "Fri",
        percentage: 0.3,
        amount: 15
    ),
]

struct DailyAmountView: View {
    var largestPercentageItem: DailyDataModel {
        data.reduce(data[0]) { prev, data in
            if prev.percentage < data.percentage {
                return data
            }
            return prev
        }
    }

    var body: some View {
        ZStack(alignment: .top) {
            HorizontalDotLine()
            HStack {
                ForEach(data) { dailyData in
                    DailyAmountItem(
                        dailyData: dailyData,
                        isHighest: largestPercentageItem
                            .id == dailyData.id
                    )
                }
            }
        }
    }
}

struct HorizontalDotLine: View {
    var body: some View {
        HStack {
            Rectangle()
                .stroke(
                    .gray,
                    style: .init(lineWidth: 0.2, lineCap: .square, dash: [1, 5])
                )
                .frame(height: 1)
        }
    }
}

struct DailyAmountItem: View {
    let dailyData: DailyDataModel
    let isHighest: Bool
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Rectangle().frame(width: 1, height: 100)
                if isHighest {
                    Circle()
                        .fill(.lightGreen)
                        .frame(width: 20)
                        .offset(y: -100 * dailyData.percentage + 6)
                }
                Circle().frame(width: 8)
                    .offset(y: -100 * dailyData.percentage)
            }
            Text(dailyData.day).fontWeight(isHighest ? .bold : .regular)
            Text("\(dailyData.amount)")
                .fontWeight(isHighest ? .bold : .regular)
        }.padding()
    }
}

#Preview {
    DailyAmountView()
}
