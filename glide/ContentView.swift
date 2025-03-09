//
//  ContentView.swift
//  glide
//
//  Created by Mauro B on 9/3/25.
//

import SwiftUI

struct Tab {
    var title: String
    var url: URL
}

struct TransparentWindowView: View {
    @State private var tabs: [Tab] = [
        Tab(title: "Apple", url: URL(string: "https://www.apple.com")!),
        Tab(title: "Google", url: URL(string: "https://www.google.com")!),
        Tab(title: "GitHub", url: URL(string: "https://www.github.com")!)
    ]
    
    @State private var selectedTabIndex: Int = 0
    
    private var contentInset: CGFloat = 10

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                // Background blur effect
                VisualEffectBlur(material: .underWindowBackground)
                    .edgesIgnoringSafeArea(.all)

                // Overlay to reduce blur opacity
                Color.white.opacity(0.1)
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 0) {
                    // Browser view displaying the current tab
                    BrowserView(url: tabs[selectedTabIndex].url)
                        .frame(width: proxy.size.width - contentInset * 2, height: proxy.size.height - contentInset * 2)
                        .cornerRadius(8)
                        .shadow(color: Color.black.opacity(0.3), radius: contentInset, x: 0, y: 0)
                }
                .padding(EdgeInsets(top: 0, leading: contentInset, bottom: 0, trailing: contentInset))
                .onAppear {
                    makeWindowTransparent()
                }
            }
        }
    }

    private func makeWindowTransparent() {
        if let window = NSApp.windows.first {
            window.isOpaque = false
            window.backgroundColor = NSColor.clear
            window.styleMask = [.titled, .resizable, .fullSizeContentView] // Resizable with borders
            window.titlebarAppearsTransparent = true
            window.isMovableByWindowBackground = true

            // Hide traffic lights (close, minimize, zoom)
            window.standardWindowButton(.closeButton)?.isHidden = true
            window.standardWindowButton(.miniaturizeButton)?.isHidden = true
            window.standardWindowButton(.zoomButton)?.isHidden = true
            window.titleVisibility = .hidden // Hide title completely
        }
    }
}

struct VisualEffectBlur: NSViewRepresentable {
    let material: NSVisualEffectView.Material
    let blendingMode: NSVisualEffectView.BlendingMode = .behindWindow

    func makeNSView(context: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()
        view.material = material
        view.blendingMode = blendingMode
        view.state = .active
        return view
    }

    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {}
}
