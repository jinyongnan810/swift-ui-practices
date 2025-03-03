//
//  ButtonsView.swift
//  BodyShape
//
//  Created by Yuunan kin on 2025/03/03.
//

import SwiftUI

enum ButtonType: String {
    case home = "house.fill"
    case bookmark = "bookmark.fill"
    case alarm = "alarm.fill"
    case share = "square.and.arrow.up.on.square.fill"
}

struct ButtonsView: View {
    @State var selectedButtonType: ButtonType = .home
    var body: some View {
        HStack {
            ButtonView(buttonType: .home, selected: $selectedButtonType)
            ButtonView(buttonType: .bookmark, selected: $selectedButtonType)
            ButtonView(buttonType: .alarm, selected: $selectedButtonType)
            ButtonView(buttonType: .share, selected: $selectedButtonType)
        }
    }
}

struct ButtonView: View {
    let buttonType: ButtonType
    @Binding var selected: ButtonType
    var body: some View {
        Image(systemName: buttonType.rawValue)
            .imageScale(.large)
            .padding()
            .background(
                Circle()
                    .fill(selected == buttonType ? .lightGreen : Color.clear)
            )
            .onTapGesture {
                withAnimation {
                    selected = buttonType
                }
            }
            .padding()
    }
}

#Preview {
    ButtonsView()
}
