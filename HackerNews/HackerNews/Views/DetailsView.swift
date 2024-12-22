//
//  DetailsView.swift
//  HackerNews
//
//  Created by Yuunan kin on 2024/12/22.
//

import SwiftUI
import WebKit

struct DetailsView: View {
    let url: String?
    var body: some View {
        WebView(urlString: url)
    }
}

#Preview {
    DetailsView(url: "https://news.ycombinator.com")
}
