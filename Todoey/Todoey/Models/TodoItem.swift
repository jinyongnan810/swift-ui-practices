//
//  Item.swift
//  Todoey
//
//  Created by Yuunan kin on 2024/12/27.
//
import SwiftUI

struct TodoItem: Identifiable, Codable {
    let id: String
    var title: String
    var done: Bool

    mutating func toggleDone() {
        done.toggle()
    }
}
