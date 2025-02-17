//
//  SelectActivityView.swift
//  Alarm
//
//  Created by Yuunan kin on 2025/02/15.
//

import SwiftUI

struct SelectActivityView: View {
    @Binding var colorIndex: Int
    @Binding var activity: String
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                ForEach(
                    Array(mainColors.enumerated()),
                    id: \.element
                ) { index, color in
                    ColorPickerItem(
                        color: color,
                        selected: index == colorIndex
                    )
                    .onTapGesture {
                        withAnimation {
                            colorIndex = index
                        }
                    }
                }
            }.padding()
            ScrollView(.horizontal) {
                HStack {
                    ForEach(Array(activities.enumerated()), id: \.element) { _, activity in
                        ActivityPickerView(activity: activity, selected: self.activity == activity,
                                           selectedColor: mainColors[colorIndex]).onTapGesture {
                            withAnimation {
                                self.activity = activity
                            }
                        }
                    }
                }
            }.scrollIndicators(.hidden)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.myNickel, lineWidth: 1)
        }
    }
}

struct ColorPickerItem: View {
    let color: Color
    let selected: Bool
    var body: some View {
        Circle().fill(color).frame(width: 20)
            .shadow(color: color, radius: 10)
            .overlay {
                Circle().stroke(.black, style: StrokeStyle(lineWidth: selected ? 3 : 1))
            }
    }
}

struct ActivityPickerView: View {
    let activity: String
    let selected: Bool
    let selectedColor: Color
    var selectedBackgroundColor: Color {
        selectedColor == .myBlack ? .white : .black
    }

    var body: some View {
        Image(systemName: activity)
            .imageScale(selected ? .large : .medium)
            .foregroundStyle(selected ? selectedColor : .myNickel)
            .opacity(selected ? 1 : 0.7)
            .padding(7)
            .background(
                ZStack {
                    Circle().fill(selected ? selectedBackgroundColor : .clear)
                    Circle().stroke(selected ? selectedColor : .clear)
                }
            )
    }
}

#Preview {
    SelectActivityView(
        colorIndex: .constant(0),
        activity: .constant(activities[0])
    )
}
