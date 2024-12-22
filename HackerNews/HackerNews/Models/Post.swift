//
//  Post.swift
//  HackerNews
//
//  Created by Yuunan kin on 2024/12/22.
//

struct Results: Decodable {
    let hits: [Post]
}

struct Post: Decodable, Identifiable {
    var id: String { objectID }
    let title: String
    let points: Int
    let url: String?
    let objectID: String
}
