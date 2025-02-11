//
//  HIghScoreViewModel.swift
//  AddingGame
//
//  Created by Yuunan kin on 2025/02/10.
//
import CoreData
import Foundation

class HighScoreViewModel: ObservableObject {
    let container: NSPersistentContainer

    @Published var highScores: [HighScoreEntity] = []
    var highestScore: Int {
        if let first = highScores.first {
            return Int(first.score)
        }
        return 0
    }

    init() {
        container = NSPersistentContainer(name: "HighScoresDataModel")

        container.loadPersistentStores { _, error in
            if let error {
                print("⭐️ Loading HighScoreDataModel failed: \(error)")
            } else {
                print("⭐️ Loading HighScoreDataModel succeeded.")
            }
        }
        fetchHighScores()
    }

    func fetchHighScores() {
        let fetchRequest: NSFetchRequest<HighScoreEntity> = HighScoreEntity.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "score", ascending: false)]

        do {
            highScores = try container.viewContext.fetch(fetchRequest)
        } catch {
            print("⭐️ Fetching high scores failed: \(error)")
        }
    }

    func addHighScore(name: String, score: Int) {
        let highScore = HighScoreEntity(context: container.viewContext)
        highScore.name = name
        highScore.score = Int64(score)
        highScore.id = UUID()
        highScores.append(highScore)
        saveHighScores()
    }

    func updateHighScoreUserName(entity: HighScoreEntity, newName: String) {
        entity.name = newName
        saveHighScores()
    }

    func deleteHighScore(entity: HighScoreEntity) {
        container.viewContext.delete(entity)
        saveHighScores()
    }

    func saveHighScores() {
        do {
            try container.viewContext.save()
            fetchHighScores()
        } catch {
            print("⭐️ Saving high scores failed: \(error)")
        }
    }
}
