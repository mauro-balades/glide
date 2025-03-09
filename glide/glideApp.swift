//
//  glideApp.swift
//  glide
//
//  Created by Mauro B on 9/3/25.
//

import SwiftUI

@main
struct glideApp: App {
    var body: some Scene {
        WindowGroup {
            TransparentWindowView()
        }
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}
