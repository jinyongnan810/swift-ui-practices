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

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        var activityIndicator: UIActivityIndicatorView

        init(parent: WebView, activityIndicator: UIActivityIndicatorView) {
            self.parent = parent
            self.activityIndicator = activityIndicator
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            activityIndicator.startAnimating()
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            activityIndicator.stopAnimating()
        }

        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            activityIndicator.stopAnimating()
        }
    }

    func makeCoordinator() -> Coordinator {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        return Coordinator(parent: self, activityIndicator: activityIndicator)
    }

    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator

        let activityIndicator = context.coordinator.activityIndicator
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        view.addSubview(activityIndicator)

        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        return view
    }

    func updateUIView(_ uiView: UIViewType, context _: Context) {
        guard let urlString else { return }
        guard let url = URL(string: urlString) else { return }
        guard let webView = uiView.subviews.compactMap({ $0 as? WKWebView }).first else { return }
        webView.load(URLRequest(url: url))
    }
}
