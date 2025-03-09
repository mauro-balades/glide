//
//  BrowserView.swift
//  glide
//
//  Created by Mauro B on 9/3/25.
//

import SwiftUI
import WebKit

struct BrowserView: NSViewRepresentable {
    var url: URL

    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    func makeNSView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.uiDelegate = context.coordinator
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateNSView(_ nsView: WKWebView, context: Context) {
        nsView.load(URLRequest(url: url)) // Update URL if changed
    }
    
    class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate {
        // You can handle WKWebView navigation or UI actions here
    }
}
