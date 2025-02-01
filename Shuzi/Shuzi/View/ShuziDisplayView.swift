//
//  ShuziDisplayView.swift
//  Shuzi
//
//  Created by Yuunan kin on 2025/02/01.
//

import SwiftUI

struct ShuziDisplayView: View {
    let number: Int
    let showPinyin: Bool
    var shuzi: ShuziWithPinyin {
        number.toShuzi()
    }

    var body: some View {
        VStack {
            Text(shuzi.chinese)
                .font(.title)
                .fontWeight(.semibold)
            Text(shuzi.pinyin)
                .font(.headline)
                .foregroundStyle(.gray)
                .opacity(showPinyin ? 1 : 0)
        }
    }
}

#Preview {
    VStack {
        ShuziDisplayView(number: 77, showPinyin: true)
        ShuziDisplayView(number: 77, showPinyin: false)
    }
}
