//
//  HighScoreModel.swift
//  AddingGame
//
//  Created by Yuunan kin on 2025/02/11.
//

import Foundation
import SwiftData

@Model
class HighScoreModel: Identifiable {
    var id = UUID()
    var name: String
    var score: Int

    init(name: String, score: Int) {
        self.name = name
        self.score = score
    }
}
