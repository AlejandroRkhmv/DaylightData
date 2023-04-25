//
//  CoordinatesView.swift
//  DaylightData
//
//  Created by Александр Рахимов on 09.04.2023.
//

import SwiftUI

struct CoordinatesView: View {
    
    //@EnvironmentObject private var coordinator: Coordinator
    @State private var latitude = "45.30"
    @State private var longitude = "40.14"
    @State private var date = "24.04.2023"
    @Binding var selected: Int
    @Binding var isCoordinatesOpen: Bool
    @Binding var isStarted: Bool
    
    var searchViewModel: SearchViewModelProtocol!
    
    init(selected: Binding<Int>, isCoordinatesOpen: Binding<Bool>, isStarted: Binding<Bool>, searchViewModel: SearchViewModelProtocol!) {
        _selected = selected
        _isCoordinatesOpen = isCoordinatesOpen
        _isStarted = isStarted
        self.searchViewModel = searchViewModel
    }
    
    var body: some View {
      
            VStack {
                Spacer()
                Group {
                    Text("latitude")
                        .customTextModifier()
                    ZStack(alignment: .leading) {
                        TextField("", text: $latitude)
                            .modifierForTextFields()
                        if self.latitude.isEmpty {
                            Text("45.16")
                                .modifireForPlaceholder()
                        }
                    }
                    Text("longitude")
                        .customTextModifier()
                    ZStack(alignment: .leading) {
                        TextField("", text: $longitude)
                            .modifierForTextFields()
                        if self.longitude.isEmpty {
                            Text("39.04")
                                .modifireForPlaceholder()
                        }
                    }
                    Text("date")
                        .customTextModifier()
                    ZStack(alignment: .leading) {
                        TextField("", text: $date)
                            .modifierForTextFields()
                        if self.date.isEmpty {
                            Text("23.01.2023")
                                .modifireForPlaceholder()
                        }
                    }
                }
                
                HStack {
                    Spacer()
                    Button {
                        withAnimation(.linear(duration: 0.5)) {
                            //coordinator.dismissFullScreenCover()
                            //coordinator.dismissSheet()
                            searchViewModel.getSunTime(latitude: latitude, longitude: longitude, date: date)
                            self.selected = 0
                            self.isCoordinatesOpen = false
                            self.isStarted = false
                        }
                    } label: {
                        Image(systemName: "sparkle.magnifyingglass")
                            .resizable()
                            .foregroundColor(Color(ColorEnum.blik.rawValue))
                            .shadow(color: Color(ColorEnum.blik.rawValue), radius: 2, x: 0, y: 0)
                            .frame(width: 30, height: 30)
                            .padding()
                            .clipShape(Circle())
                    }
                    .background {
                        Circle()
                            .fill(Color(ColorEnum.lightShadow.rawValue))
                            .shadow(color: .white, radius: 50, x: -10, y: -10)
                            .shadow(color: Color(ColorEnum.blik.rawValue), radius: 50, x: 10, y: 10)
                    }
                    .shadow(radius: 8, x: 4, y: 4)
                    .padding(.top, 130)
                    Spacer()
                }
                Spacer()
            }
            
            .background {
                LinearGradient(colors: [Color(ColorEnum.blik.rawValue), Color(ColorEnum.lightShadow.rawValue)], startPoint: .topLeading, endPoint: .bottomTrailing)
            }
        .edgesIgnoringSafeArea(.vertical)
    }
}

// MARK: - create text modifier
struct TextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 15))
            .shadow(color: .white, radius: 15, x: 0, y: 0)
            .foregroundColor(Color(ColorEnum.darkShadow.rawValue))
    }
}

// MARK: - create extension
extension View {
    func customTextModifier() -> some View {
        self.modifier(TextModifier())
    }
}
