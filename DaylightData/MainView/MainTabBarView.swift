//
//  MainTabBarView.swift
//  DaylightData
//
//  Created by Александр Рахимов on 01.04.2023.
//

import SwiftUI
import Combine

struct MainTabBarView: View {
    let dayLightViewModel = DayLightViewModel()
    @Environment(\.mainWindowSize) var window
    @State private var selected = 0
    @State private var isScemaShonw = false
    @State var currentTime = Date()
    @State private var isAppear = false
    
    var body: some View {
        
        CustomTabView(selected: $selected, isAppear: $isAppear) {
            
            // MARK: - first tab
            VStack {
                ZStack {
                    DayLightView(progress: persentOfSunAndMoon(date: currentTime))
                        .position(x: window.width * 0.25, y: window.height * 0.15)
                    CurrentDateView()
                        .position(x: window.width * 0.75, y: window.height * 0.15)
                    Image("sun")
                        .resizable()
                        .frame(width: 30, height: 30, alignment: .leading)
                        .offset(y: (window.width / 2) - 20) // radius
                        .rotationEffect(.degrees(-360 * percentOfTheDay(newDate: currentTime)))
                        .animation(Animation.easeInOut(duration: 5.5).delay(0).repeatForever(autoreverses: false), value: currentTime)
                    Twilight(window: window)
                    SunTimesView(dayLightViewModel: dayLightViewModel, window: window)
                    
                }
                .zIndex(1)
            }
            .background {
                LinearGradient(colors: [Color(ColorEnum.blik.rawValue), Color(ColorEnum.lightShadow.rawValue)], startPoint: .topLeading, endPoint: .bottomTrailing)
            }
            .tabItem {
                TabItem(title: "daylight", iconSystemName: "light.max")
            }
            .opacity(selected == 0 ? 1 : 0)
            
            
            // MARK: - second tab
            ZStack {
                CoordinatorView(window: window).environmentObject(createCoordinator())
            }
            .foregroundColor(.black)
            .fontWeight(.bold)
            .edgesIgnoringSafeArea(.all)
            .background {
                LinearGradient(colors: [Color(ColorEnum.blik.rawValue), Color(ColorEnum.lightShadow.rawValue)], startPoint: .topLeading, endPoint: .bottomTrailing)
            }
            .tabItem {
                TabItem(title: "search", iconSystemName: "sparkle.magnifyingglass")
            }
            .opacity(selected == 1 ? 1 : 0)
            .edgesIgnoringSafeArea(.vertical)
            
            // MARK: - third tab
            VStack {
              
            }
            .foregroundColor(.black)
            .fontWeight(.bold)
            .background {
                LinearGradient(colors: [Color(ColorEnum.blik.rawValue), Color(ColorEnum.lightShadow.rawValue)], startPoint: .topLeading, endPoint: .bottomTrailing)
            }
            .tabItem {
                TabItem(title: "about", iconSystemName: "questionmark.square.dashed")
            }
            .opacity(selected == 2 ? 1 : 0)
        }
        .edgesIgnoringSafeArea(.vertical)
    }
    
    private func percentOfTheDay(newDate: Date) -> Double {
        
        let calendar = Calendar(identifier: .gregorian)
        let currentDate = newDate
        let componentsOfCurrentDate = calendar.dateComponents([.year, .month, .day], from: currentDate)
        
        var componentsOfstartOfMonth = DateComponents()
        componentsOfstartOfMonth.year = componentsOfCurrentDate.year
        componentsOfstartOfMonth.month = componentsOfCurrentDate.month
        componentsOfstartOfMonth.day = componentsOfCurrentDate.day
        
        guard let start = calendar.date(from: componentsOfstartOfMonth) else { return 0 }
        let countOfSecondsFromStartDay = (currentDate.timeIntervalSince(start))
        let allDaySeconds = 24 * 60 * 60
        return countOfSecondsFromStartDay / Double(allDaySeconds)
    }
    
    private func persentOfSunAndMoon(date: Date) -> Double {
        let persent = percentOfTheDay(newDate: date)
        print(persent)
        switch persent {
        case 0...0.1:
            return 1
        case 0.11...0.15:
            return 0.5
        case 0.151...0.2:
            return 0.35
        case 0.21...0.25:
            return 0.2
        case 0.251...0.749:
            return persent - 0.5
        case 0.75...0.799:
            return 0.2
        case 0.8...0.849:
            return 0.35
        case 0.85...0.899:
            return 0.5
        case 0.9...0.99999:
            return 1
        default: break
        }
        return 0
    }
    
    private func createCoordinator() -> Coordinator {
        let coordinator = Coordinator(isAppear: $isAppear, selected: $selected, window: window)
        return coordinator
    }
    
}

