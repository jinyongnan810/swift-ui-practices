//
//  NetworkManager.swift
//  HackerNews
//
//  Created by Yuunan kin on 2024/12/22.
//
import Foundation

class NetworkManager: ObservableObject {
    @Published var posts: [Post] = []

    func fetchNews() {
        guard let url = URL(string: "https://hn.algolia.com/api/v1/search?tags=front_page") else {
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, _, error in
            if let error {
                print("Error: \(error)")
                return
            }
            guard let data else {
                print("No data")
                return
            }
            do {
                let results = try JSONDecoder().decode(Results.self, from: data)
                DispatchQueue.main.async {
                    self.posts = results.hits
                }
            } catch {
                print("Error decoding: \(error)")
            }
        }
        task.resume()
    }
}
