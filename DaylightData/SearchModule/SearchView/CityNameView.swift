//
//  CityNameView.swift
//  DaylightData
//
//  Created by Александр Рахимов on 09.04.2023.
//

import SwiftUI
import Foundation

struct CityNameView: View {
    
    //@EnvironmentObject private var coordinator: Coordinator
    @State private var cityName = "Berlin"
    @State private var date = "24.04.2023"
    @Binding var selected: Int
    @Binding var isCityOpen: Bool
    @Binding var isStarted: Bool
    
    var searchViewModel: SearchViewModelProtocol!
    
    init(selected: Binding<Int>, isCityOpen: Binding<Bool>, isStarted: Binding<Bool>, searchViewModel: SearchViewModelProtocol!) {
        _selected = selected
        _isCityOpen = isCityOpen
        _isStarted = isStarted
        self.searchViewModel = searchViewModel
    }
    
    var body: some View {
      
            VStack {
                Spacer()
                Group {
                    Text("City name")
                        .customTextModifier()
                    ZStack(alignment: .leading) {
                        if self.cityName.isEmpty {
                            Text("Saratov, Russia")
                                .modifireForPlaceholder()
                        }
                        TextField("", text: $cityName)
                            .modifierForTextFields()
                    }
                    Text("date")
                        .customTextModifier()
                    ZStack(alignment: .leading) {
                        if self.date.isEmpty {
                            Text("23.01.2023")
                                .modifireForPlaceholder()
                        }
                        TextField("", text: $date)
                            .modifierForTextFields()
                    }
                }
                
                HStack {
                    Spacer()
                    Button {
                        withAnimation(.linear(duration: 0.5)) {
                            //coordinator.dismissFullScreenCover()
                            //coordinator.dismissSheet()
                            searchViewModel.getSunTime(city: cityName, date: date)
                            self.selected = 0
                            self.isCityOpen = false
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

struct TextFieldModifire: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Courier", fixedSize: 15))
            .padding().overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(Color(ColorEnum.blik.rawValue), style: .init(lineWidth: 2))).padding()
            .foregroundColor(Color(ColorEnum.darkShadow.rawValue))
    }
}

struct PlaceholderModifire: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Courier", fixedSize: 15))
            .padding(.leading, 35)
            .foregroundColor(Color(ColorEnum.darkShadow.rawValue).opacity(0.5))
    }
}



extension View {
    func modifierForTextFields() -> some View {
        modifier(TextFieldModifire())
    }
    
    func modifireForPlaceholder() -> some View {
        modifier(PlaceholderModifire())
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

