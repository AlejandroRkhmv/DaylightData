//
//  SearchView.swift
//  DaylightData
//
//  Created by Александр Рахимов on 08.04.2023.
//

import SwiftUI

struct SearchView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @State var isStarted = false
    @Binding var isAppear: Bool
    @Binding var selected: Int
    var window: CGSize
    @State private var isCityOpen = false
    @State private var isCoordinatesOpen = false
    
    var searchViewModel: SearchViewModelProtocol!
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                ZStack {
                    Button {
                        //coordinator.present(fullScreenCover: .coordinatesView)
                        //coordinator.present(sheet: .coordinatesView)
                        isCoordinatesOpen = true
                        isStarted = false
                    } label: {
                        Text("coordinates")
                            .font(.system(size: 11))
                            .foregroundColor(Color(ColorEnum.darkShadow.rawValue))
                            .shadow(color: .white, radius: 5, x: 0, y: 0)
                            .frame(width: 70, height: 70)
                            .padding()
                            .clipShape(Circle())
                            .rotationEffect(.degrees(isStarted ? 0 : -90))
                    }
                    .background {
                        Circle()
                            .fill(Color(ColorEnum.lightShadow.rawValue).opacity( isStarted ? 1 : 0))
                            .shadow(color: .white.opacity(isStarted ? 1 : 0), radius: 75, x: -5, y: -5)
                            .shadow(color: Color(ColorEnum.blik.rawValue).opacity(isStarted ? 1 : 0), radius: 75, x: 5, y: 5)
                    }
                    .shadow(radius: 8, x: 4, y: 4)
                    .offset(x: isStarted ? 90 : 0, y: isStarted ? 150 : 0)
                    .opacity(isStarted ? 1 : 0)
                    .sheet(isPresented: $isCoordinatesOpen) {
                        CoordinatesView(selected: $selected, isCoordinatesOpen: $isCoordinatesOpen, isStarted: $isStarted, searchViewModel: searchViewModel)
                    }
                    
                    Button {
                        //coordinator.present(fullScreenCover: .cityNameView)
                        //coordinator.present(sheet: .cityNameView)
                        isCityOpen = true
                        isStarted = false
                    } label: {
                        Text("city name")
                            .font(.system(size: 11))
                            .foregroundColor(Color(ColorEnum.darkShadow.rawValue))
                            .shadow(color: .white, radius: 5, x: 0, y: 0)
                            .frame(width: 70, height: 70)
                            .padding()
                            .clipShape(Circle())
                            .rotationEffect(.degrees(isStarted ? 0 : -90))
                    }
                    .background {
                        Circle()
                            .fill(Color(ColorEnum.lightShadow.rawValue).opacity( isStarted ? 1 : 0))
                            .shadow(color: .white.opacity(isStarted ? 1 : 0), radius: 75, x: -5, y: -5)
                            .shadow(color: Color(ColorEnum.blik.rawValue).opacity(isStarted ? 1 : 0), radius: 75, x: 5, y: 5)
                    }
                    .shadow(radius: 8, x: 4, y: 4)
                    .offset(x: isStarted ? -90 : 0, y: isStarted ? 150 : 0)
                    .opacity(isStarted ? 1 : 0)
                    .sheet(isPresented: $isCityOpen) {
                        CityNameView(selected: $selected, isCityOpen: $isCityOpen, isStarted: $isStarted, searchViewModel: searchViewModel)
                    }
                    
                    Button {
                        withAnimation(.linear(duration: 0.5)) {
                            isStarted.toggle()
                        }
                    } label: {
                        Image(systemName: "sparkle.magnifyingglass")
                            .resizable()
                            .foregroundColor(Color(ColorEnum.blik.rawValue))
                            .shadow(color: Color(ColorEnum.blik.rawValue), radius: 2, x: 0, y: 0)
                            .frame(width: isAppear ? 70 : window.width * 0.5, height: isAppear ? 70 : window.width * 0.5)
                            .padding()
                            .clipShape(Circle())
                            .rotationEffect(.degrees(isStarted ? 360 : 0))
                            .opacity(isAppear ? 1 : 0)
                    }
                    .background {
                        Circle()
                            .fill(Color(ColorEnum.lightShadow.rawValue).opacity( isStarted ? 0 : 1))
                            .shadow(color: .white.opacity(isStarted ? 0 : 1), radius: 50, x: -10, y: -10)
                            .shadow(color: Color(ColorEnum.blik.rawValue).opacity(isStarted ? 0 : 1), radius: 50, x: 10, y: 10)
                    }
                    .shadow(radius: 8, x: 4, y: 4)
                }
                Spacer()
            }
            Spacer()
        }
        .background {
            LinearGradient(colors: [Color(ColorEnum.blik.rawValue), Color(ColorEnum.lightShadow.rawValue)], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
        .edgesIgnoringSafeArea(.all)
    }
}
