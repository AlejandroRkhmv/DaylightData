//
//  Coordinator.swift
//  DaylightData
//
//  Created by Александр Рахимов on 09.04.2023.
//

import SwiftUI

enum Page: String, Identifiable {
    case searchView
    
    var id: String {
        self.rawValue
    }
}

enum Sheet: String, Identifiable {
    case cityNameView
    case coordinatesView
    
    var id: String {
        self.rawValue
    }
}

//enum FullScreenCover: String, Identifiable {
//
//    case cityNameView
//    case coordinatesView
//
//    var id: String {
//        self.rawValue
//    }
//}

class Coordinator: ObservableObject {
    
    @Published var path = NavigationPath()
    @Published var sheet: Sheet?
    //@Published var fullScreenCover: FullScreenCover?
    @Binding var isAppear: Bool
    @Binding var selected: Int
    var window: CGSize
    let searchViewModel = SearchViewModel()
    
    init(isAppear: Binding<Bool>, selected: Binding<Int>, window: CGSize) {
        _isAppear = isAppear
        _selected = selected
        self.window = window
    }
    
    func push(_ page: Page) {
        path.append(page)
    }
    
//    func pop() {
//        path.removeLast()
//    }
    
    func present(sheet: Sheet) {
        self.sheet = sheet
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
//    func present(fullScreenCover: FullScreenCover) {
//        self.fullScreenCover = fullScreenCover
//    }
//
//    func dismissFullScreenCover() {
//        self.fullScreenCover = nil
//    }
    
    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
        case .searchView:
            SearchView(isAppear: $isAppear, selected: $selected, window: window, searchViewModel: searchViewModel)
        }
    }
    
//    @ViewBuilder
//    func build(sheet: Sheet) -> some View {
//        switch sheet {
//        case .cityNameView:
//            NavigationStack {
//                CityNameView()
//            }
//        case .coordinatesView:
//            NavigationStack {
//                CoordinatesView()
//            }
//        }
//    }
    
//    @ViewBuilder
//    func build(fullScreenCover: FullScreenCover) -> some View {
//        switch fullScreenCover {
//        case .cityNameView:
//            NavigationStack {
//                CityNameView()
//            }
//        case .coordinatesView:
//            NavigationStack {
//                CoordinatesView()
//            }
//        }
//    }
}

