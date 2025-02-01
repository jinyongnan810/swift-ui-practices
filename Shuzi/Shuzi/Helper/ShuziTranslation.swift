//
//  ShuziTranslation.swift
//  Shuzi
//
//  Created by Yuunan kin on 2025/02/01.
//


let chineseDigitsWithPinyin: [(chinese: String, pinyin: String)] = [
    ("零", "líng"),
    ("一", "yī"),
    ("二", "èr"),
    ("三", "sān"),
    ("四", "sì"),
    ("五", "wǔ"),
    ("六", "liù"),
    ("七", "qī"),
    ("八", "bā"),
    ("九", "jiǔ"),
    ("十", "shí"),
]

extension Int {
    func toShuzi() -> (chinese: String, pinyin: String) {
        switch self {
            case 0 ... 10:
                return chineseDigitsWithPinyin[self]
            case 11 ... 19:
                let unit = self % 10
                let chinese = "十 " + (chineseDigitsWithPinyin[unit].chinese)
                let pinyin = "shí " + (chineseDigitsWithPinyin[unit].pinyin)
                return (chinese, pinyin)
            case 20 ... 99:
                let tenth = self / 10
                if self % 10 == 0 {
                    let chinese = chineseDigitsWithPinyin[tenth].chinese + " 十"
                    let pinyin = chineseDigitsWithPinyin[tenth].pinyin + " shí"
                    return (chinese, pinyin)
                }

                let unit = self % 10
                let chinese = chineseDigitsWithPinyin[tenth].chinese + " 十 " + chineseDigitsWithPinyin[unit].chinese
                let pinyin = chineseDigitsWithPinyin[tenth].pinyin + " shí " + chineseDigitsWithPinyin[unit].pinyin
                return (chinese, pinyin)
            default:
                return (chinese: "", pinyin: "")
        }
    }
}
