//
//  HIghScoreViewModel.swift
//  AddingGame
//
//  Created by Yuunan kin on 2025/02/10.
//
import CoreData
import Foundation
import Observation
import SwiftData

@Observable
class HighScoreViewModel {
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchHighScores()
    }

    var modelContext: ModelContext

    var highScores: [HighScoreModel] = []
    var highestScore: Int {
        if let first = highScores.first {
            return Int(first.score)
        }
        return 0
    }

    func fetchHighScores() {
        do {
            let descriptor = FetchDescriptor<HighScoreModel>(
                sortBy: [SortDescriptor(\.score, order: .reverse)]
            )
            highScores = try modelContext.fetch(descriptor)
            print("⭐️ high scores fetched: \(highScores)")
        } catch {
            print("⭐️ Fetching high scores failed: \(error)")
        }
    }

    func addHighScore(name: String, score: Int) {
        let highScore = HighScoreModel(name: name, score: score)
        modelContext.insert(highScore)
        saveHighScores()
    }

    func updateHighScoreUserName(entity: HighScoreModel, newName: String) {
        entity.name = newName
        saveHighScores()
    }

    func deleteHighScore(indexSet: IndexSet) {
        for item in indexSet {
            modelContext.delete(highScores[item])
        }
        saveHighScores()
    }

    func saveHighScores() {
        do {
            try modelContext.save()
            fetchHighScores()
        } catch {
            print("⭐️ Saving high scores failed: \(error)")
        }
    }
}
