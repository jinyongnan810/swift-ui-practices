//
//  main.swift
//  TwitterSentimentModelMaker
//
//  Created by Yuunan kin on 2025/01/03.
//

import Cocoa
import CoreML
import CreateML
import TabularData

// MARK: - Make and train model

enum DataError: Error {
    case failedToCreateURL
    case failedToLoadData
    case failedToCreateModel
    case failedToLoadModel
}

let csvFileURL = URL(fileURLWithPath: "/Users/kin/Documents/GitHub/swift-ui-practices/TwitterSentimentModelMaker/TwitterSentimentModelMaker/twitter-sanders-apple3.csv")

guard let dataFrame = try? DataFrame(contentsOfCSVFile: csvFileURL) else {
    throw DataError.failedToLoadData
}

let (trainingData, testingData) = dataFrame.randomSplit(by: 0.8, seed: 5)
let classifierTrainingFrame = DataFrame(trainingData)
let classifierTestingFrame = DataFrame(testingData)

guard let sentimentClassifier = try? MLTextClassifier(
    trainingData: classifierTrainingFrame,
    textColumn: "text",
    labelColumn: "class"
) else {
    throw DataError.failedToCreateModel
}

let evaluation = sentimentClassifier.evaluation(on: classifierTestingFrame, textColumn: "text",
                                                labelColumn: "class")
let accuracy = (1.0 - evaluation.classificationError) * 100.0
print("⭐️ accuracy: \(accuracy)%")

let metadata = MLModelMetadata(author: "Yuunan kin")
try sentimentClassifier.write(to: URL(fileURLWithPath: "/Users/kin/Documents/GitHub/swift-ui-practices/TwitterSentimentModelMaker/TwitterSentimentModelMaker/MySentimentClassifier.mlmodel"), metadata: metadata)
print("⭐️ model saved.")

let resultExpectPositive = try sentimentClassifier.prediction(from: "I think apple vision pro is a good product.")
let resultExpectNegative = try sentimentClassifier.prediction(from: "I think apple vision pro is a bad product.")
let resultExpectNeutral = try sentimentClassifier.prediction(from: "I think apple vision pro has few flaws, but overall ok.")
print("resultExpectPositive: \(resultExpectPositive)")
print("resultExpectNegative: \(resultExpectNegative)")
print("resultExpectNeutral: \(resultExpectNeutral)")

// MARK: - Load model and make predictions

guard let loadedClassifier = try? MySentimentClassifier(configuration: .init()) else {
    throw DataError.failedToLoadModel
}

let results = try? loadedClassifier.predictions(inputs: [
    .init(text: "I think apple vision pro is a good product."),
    .init(text: "I think apple vision pro is a bad product."),
    .init(text: "I think apple vision pro has few flaws, but overall ok."),
])
print("⭐️ predictions when using loaded model:")
results?.forEach { print($0.label) }
