//
//  SunTimesView.swift
//  DaylightData
//
//  Created by Александр Рахимов on 08.04.2023.
//

import SwiftUI

struct SunTimesView<Model>: View where Model: DaiLightViewModelProtocol {
    
    var window: CGSize
    @StateObject private var dayLightViewModel: Model
    
    init (dayLightViewModel: Model, window: CGSize) {
        self.window = window
        _dayLightViewModel = StateObject(wrappedValue: dayLightViewModel)
    }
    
    var body: some View {
        Text(dayLightViewModel.storage?.cityName ?? "")
            .font(.system(size: 20))
            .position(x: window.width * 0.5, y: window.height * 0.26)
            .shadow(color: .white, radius: 15, x: 0, y: 0)
        Group {
            Text(dayLightViewModel.storage?.returnSunTime()?.sunset ?? "")
                .font(.system(size: 12))
                .position(x: window.width * 0.19, y: window.height * 0.555)
                .shadow(color: .white, radius: 15, x: 0, y: 0)
            Text(dayLightViewModel.storage?.returnSunTime()?.sunrise ?? "")
                .font(.system(size: 12))
                .position(x: window.width * 0.81, y: window.height * 0.555)
                .shadow(color: .white, radius: 15, x: 0, y: 0)
            
            Text(dayLightViewModel.storage?.returnSunTime()?.civilTwilightEnd ?? "")
                .font(.system(size: 12))
                .position(x: window.width * 0.2, y: window.height * 0.595)
                .shadow(color: .white, radius: 10, x: 0, y: 0)
            Text(dayLightViewModel.storage?.returnSunTime()?.civilTwilightBegin ?? "")
                .font(.system(size: 12))
                .position(x: window.width * 0.8, y: window.height * 0.595)
                .shadow(color: .white, radius: 10, x: 0, y: 0)
            
            Text(dayLightViewModel.storage?.returnSunTime()?.nauticalTwilightEnd ?? "")
                .font(.system(size: 12))
                .position(x: window.width * 0.23, y: window.height * 0.635)
                .shadow(color: .white, radius: 5, x: 0, y: 0)
            Text(dayLightViewModel.storage?.returnSunTime()?.nauticalTwilightBegin ?? "")
                .font(.system(size: 12))
                .position(x: window.width * 0.77, y: window.height * 0.635)
                .shadow(color: .white, radius: 5, x: 0, y: 0)
            
            Text(dayLightViewModel.storage?.returnSunTime()?.astronomicalTwilightEnd ?? "")
                .font(.system(size: 12))
                .position(x: window.width * 0.28, y: window.height * 0.67)
                .shadow(color: .white, radius: 3, x: 0, y: 0)
            Text(dayLightViewModel.storage?.returnSunTime()?.astronomicalTwilightBegin ?? "")
                .font(.system(size: 12))
                .position(x: window.width * 0.72, y: window.height * 0.67)
                .shadow(color: .white, radius: 3, x: 0, y: 0)
        }
        .foregroundColor(Color(ColorEnum.darkShadow.rawValue))
    }
}

