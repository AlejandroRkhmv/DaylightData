//
//  CoordinatorView.swift
//  DaylightData
//
//  Created by Александр Рахимов on 09.04.2023.
//

import SwiftUI

struct CoordinatorView: View {
    
    var window: CGSize
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(page: .searchView)
                .navigationDestination(for: Page.self) { page in
                    coordinator.build(page: page)
                }
//                .fullScreenCover(item: $coordinator.fullScreenCover) { fullScreenCover in
//                    coordinator.build(fullScreenCover: fullScreenCover)
//                }
//                .sheet(item: $coordinator.sheet, onDismiss: {
//                    print("onDismiss")
//                }) { sheet in
//                    coordinator.build(sheet: sheet)
//                }
        }
    }
}

