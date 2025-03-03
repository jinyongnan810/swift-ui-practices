//
//  DataSummariesView.swift
//  BodyShape
//
//  Created by Yuunan kin on 2025/03/03.
//

import SwiftUI

struct DataSummariesView: View {
    let padding: CGFloat = 8
    var body: some View {
        GeometryReader { geo in
            VStack {
                HStack {
                    CaloriesView()
                        .frame(width: geo.size.width * 0.6 - padding)
                    Spacer()
                    WalkingView()
                        .frame(width: geo.size.width * 0.4 - padding)
                }
                HStack {
                    StartView()
                        .frame(width: geo.size.width * 0.4 - padding)
                    Spacer()
                    MembersView()
                        .frame(width: geo.size.width * 0.6 - padding)
                }
            }
        }
    }
}

struct CaloriesView: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "fork.knife").imageScale(.large)
                    .foregroundStyle(.black)
                    .padding()
                    .background(Circle().fill(.white))
                Text("36%")
                    .font(.title2)
                    .fontWeight(.semibold)

                Image(systemName: "arrow.down")
                    .fontWeight(.semibold)
            }
            HStack(alignment: .center) {
                Text("322.0")
                    .font(.title)
                    .fontWeight(.bold)
                Text("Calories")
                    .font(.subheadline)
            }
        }.toCard(backgroundColor: .lightPurple)
    }
}

struct WalkingView: View {
    var body: some View {
        VStack {
            Image(systemName: "figure.walk")
                .imageScale(.large)
                .foregroundStyle(.black)
                .padding()
                .background(Circle().fill(.lightPurple))
            Text("4567")
                .font(.largeTitle)
                .fontWeight(.bold)
        }.toCard(hasBorder: true)
    }
}

struct StartView: View {
    var body: some View {
        VStack {
            Text("Start")
                .foregroundColor(.white)
                .font(.title)
                .fontWeight(.bold)
        }.toCard(backgroundColor: .black)
    }
}

struct MembersView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Members")
                .font(.title3)
                .fontWeight(.bold)
            HStack(spacing: -10) {
                Image(person1)
                    .resizable()
                    .scaledToFill()
                    .toIcon()
                Image(person2)
                    .resizable()
                    .scaledToFill()
                    .toIcon()
                Image(person3)
                    .resizable()
                    .scaledToFill()
                    .toIcon()
                ZStack {
                    Circle()
                        .fill(.white)
                    Text("+8")
                        .fontWeight(.semibold)
                }
                .toIcon(borderColor: .black)
            }
        }.toCard(hasBorder: true)
    }
}

struct MemberIconView: View {
    var body: some View {
        Image(person1)
            .resizable()
            .scaledToFill()
    }
}

struct IconViewModifier: ViewModifier {
    var borderColor: Color = .gray
    init(borderColor: Color = .gray) {
        self.borderColor = borderColor
    }

    func body(content: Content) -> some View {
        content.frame(width: 50, height: 50).clipShape(.circle)
            .overlay {
                Circle().stroke(borderColor, lineWidth: 1)
            }
    }
}

struct CardViewModifier: ViewModifier {
    var hasBorder: Bool = false
    var backgroundColor: Color = .clear
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 140)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 20).fill(backgroundColor)
                    if hasBorder {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.black, lineWidth: 2)
                    }
                }
            )
            .clipShape(
                .rect(cornerRadius: 20)
            )
    }
}

extension View {
    func toIcon(borderColor: Color = .gray) -> some View {
        modifier(IconViewModifier(borderColor: borderColor))
    }

    func toCard(hasBorder: Bool = false, backgroundColor: Color = .clear) -> some View {
        modifier(CardViewModifier(hasBorder: hasBorder, backgroundColor: backgroundColor))
    }
}

#Preview {
    DataSummariesView()
}
