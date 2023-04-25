//
//  ContentView.swift
//  DaylightData
//
//  Created by Александр Рахимов on 31.03.2023.
//

import SwiftUI

struct DayLightView: View {
    
    @State var progress: Double
    
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    SunView(progress: progress)
                    MoonView(progress: progress)
                }
            }
        }
    }
}
