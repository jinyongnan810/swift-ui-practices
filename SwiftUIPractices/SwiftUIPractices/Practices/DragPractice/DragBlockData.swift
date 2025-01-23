//
//  DragBlockData.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/23.
//
import SwiftUI

let colors: [Color] = [.red, .green, .yellow, .blue, .orange, .purple]
struct DragBlockData: Identifiable, Equatable {
    let id: UUID = UUID()
    let image: String
    let color: Color
    let zIndex: Double

    init(image: String, color: Color, zIndex: Double) {
        self.image = image
        self.color = color
        self.zIndex = zIndex
    }

    init (image: String, color: Color) {
        self.image = image
        self.color = .blue
        self.zIndex = 0
    }

    init (image: String) {
        self.image = image
        self.color = colors.randomElement() ?? .red
        self.zIndex = 0
    }
}
