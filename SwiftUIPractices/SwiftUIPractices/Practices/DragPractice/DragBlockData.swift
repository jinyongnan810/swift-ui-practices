//
//  DragBlockData.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/23.
//
import SwiftUI

let colors: [Color] = [.red, .green, .yellow, .blue, .orange, .purple]
struct DragBlockData: Identifiable, Equatable {
    let id: UUID = .init()
    let image: String
    let color: Color
    let zIndex: Double

    init(image: String, color: Color, zIndex: Double) {
        self.image = image
        self.color = color
        self.zIndex = zIndex
    }

    init(image: String, color _: Color) {
        self.image = image
        color = .blue
        zIndex = 0
    }

    init(image: String) {
        self.image = image
        color = colors.randomElement() ?? .red
        zIndex = 0
    }
}
