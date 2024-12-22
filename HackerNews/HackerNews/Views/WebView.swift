//
//  WebView.swift
//  HackerNews
//
//  Created by Yuunan kin on 2024/12/22.
//
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let urlString: String?

    func makeUIView(context _: Context) -> some UIView {
        WKWebView()
    }

    func updateUIView(_ uiView: UIViewType, context _: Context) {
        guard let urlString else { return }
        guard let url = URL(string: urlString) else { return }
        guard let view = uiView as? WKWebView else { return }
        view.load(URLRequest(url: url))
    }
}
