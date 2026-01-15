//
//  Models.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2026/01/12.
//
import SwiftUI

struct Month: Identifiable {
    var id: String = UUID().uuidString
    var name: String
    var date: Date
    var weeks: [Week]
}

struct Week: Identifiable {
    var id: String = UUID().uuidString
    var days: [Day]
    var isLast: Bool = false
}

struct Day: Identifiable {
    var id: String = UUID().uuidString
    var value: Int?
    var date: Date?
    var isPlaceholder: Bool = false
}

struct ScrollInfo: Equatable {
    var offsetY: CGFloat = 0
    var contentHeight: CGFloat = 0
    var containerHeight: CGFloat = 0
}
