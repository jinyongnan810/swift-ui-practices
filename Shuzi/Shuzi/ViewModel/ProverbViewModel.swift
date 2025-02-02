//
//  ProverbViewModel.swift
//  Shuzi
//
//  Created by Yuunan kin on 2025/02/01.
//

import Foundation
import Observation

@Observable
final class ProverbViewModel {
    var proverb: String?
    var translation: String?

    func fetchProverb() {
        proverb = nil
        translation = nil
        guard let url = URL(string: "https://chinese-proverbs.onrender.com/api/proverbs/random") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
//        let task = URLSession.shared.dataTask(with: url) {
        let task = URLSession.shared.dataTask(with: request) {
            data,
                _,
                error in
            if let error {
                print("Error: \(error)")
                return
            }
            guard let data else {
                print("No data")
                return
            }
            do {
                let results = try JSONDecoder().decode(
                    ProverbModel.self,
                    from: data
                )
                print("⭐️ data: \(results)")
                DispatchQueue.main.async {
                    self.proverb = results.proverb
                    self.translation = results.translation
                }
            } catch {
                print("Error decoding: \(error)")
            }
        }
        task.resume()
    }
}
