//
//  DaylightDataApp.swift
//  DaylightData
//
//  Created by Александр Рахимов on 31.03.2023.
//

import SwiftUI

@main
struct DaylightDataApp: App {
    var body: some Scene {
        WindowGroup {
            GeometryReader { proxy in
                MainTabBarView().environment(\.mainWindowSize, proxy.size)
            }
        }
    }
}

private struct MainWindowSizeKey: EnvironmentKey {
    static let defaultValue: CGSize = .zero
}

extension EnvironmentValues {
    var mainWindowSize: CGSize {
        get { self[MainWindowSizeKey.self] }
        set { self[MainWindowSizeKey.self] = newValue }
    }
}
