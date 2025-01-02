//
//  ProcessImageHelper.swift
//  SeeAndRecognize
//
//  Created by Yuunan kin on 2025/01/02.
//
import CoreML
import UIKit
import Vision

func processImage(_ image: UIImage) -> String? {
    guard let ciImage = CIImage(image: image) else {
        print("⭐️<#text#>")
        return nil
    }

    guard let model = try? VNCoreMLModel(for: MobileNetV2(configuration: .init()).model) else {
        print("⭐️ failed to load MobileNetV2 model")
        return nil
    }

    var result: String?

    let request = VNCoreMLRequest(model: model) { request, _ in
        guard let results = request.results as? [VNClassificationObservation]
        else {
            result = nil
            return
        }
        let resultsAndConfidence = results.prefix(5).map { result in
            "\(result.identifier): \(result.confidence) \n"
        }

        result = resultsAndConfidence.joined()
        print("⭐️ identified successfully")
    }

    let handler = VNImageRequestHandler(ciImage: ciImage)

    do {
        try handler.perform([request])
        print("⭐️ Vision request completed")
    } catch {
        print("⭐️ failed to perform Vision request: \(error)")
    }

    return result
}
