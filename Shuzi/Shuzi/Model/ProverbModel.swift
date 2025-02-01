//
//  ProverbModel.swift
//  Shuzi
//
//  Created by Yuunan kin on 2025/02/01.
//
// API: https://chinese-proverbs.onrender.com/api/proverbs/random
// parsed with: https://app.quicktype.io
struct ProverbModel: Codable {
    let id, proverb, pinyin, translation: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case proverb, pinyin, translation
    }
}
