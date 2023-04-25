//
//  TwinLightView.swift
//  DaylightData
//
//  Created by Александр Рахимов on 01.04.2023.
//

import SwiftUI

struct TwiLightView: View {
    
    var window: CGSize
    
    var body: some View {
        Twilight(window: window)
    }
}

struct TwinLightView_Previews: PreviewProvider {
    static var previews: some View {
        TwiLightView(window: CGSize(width: 300, height: 300))
    }
}

struct Twilight: View {
    var window: CGSize
    var body: some View {
        ZStack {
            Round(window: window)
                .fill(Color(ColorEnum.lightShadow.rawValue))
                .shadow(color: Color(ColorEnum.blik.rawValue), radius: 2, x: 0, y: 0)
            
            Night(window: window)
                .fill(Color(ColorEnum.blik.rawValue).opacity(0.1))
                .shadow(color: Color(ColorEnum.blik.rawValue), radius: 2, x: 0, y: 0)
            
            Group {
                AstronomicalDusk(window: window)
                    .fill((Color(ColorEnum.lightShadow.rawValue)).opacity(0.3))
                NauticalDusk(window: window)
                    .fill((Color(ColorEnum.lightShadow.rawValue)).opacity(0.4))
                CivilDusk(window: window)
                    .fill((Color(ColorEnum.lightShadow.rawValue)).opacity(0.5))
                AstronomicalDusk(window: window)
                    .fill((Color(ColorEnum.lightShadow.rawValue)).opacity(0.3))
                    .rotationEffect(.degrees(225))
                NauticalDusk(window: window)
                    .fill((Color(ColorEnum.lightShadow.rawValue)).opacity(0.4))
                    .rotationEffect(.degrees(210))
                CivilDusk(window: window)
                    .fill((Color(ColorEnum.lightShadow.rawValue)).opacity(0.5))
                    .rotationEffect(.degrees(195))
            }
        }
        .zIndex(3)
    }
}

struct Round: Shape {
    var window: CGSize
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: window.width * 0.5 / 2, startAngle: .zero, endAngle: .degrees(180), clockwise: true)
        return path
    }
}

struct Night: Shape {
    var window: CGSize
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: window.width * 0.5 / 2, startAngle: .zero, endAngle: .degrees(180), clockwise: false)
        return path
    }
}

struct AstronomicalDusk: Shape {
    var window: CGSize
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: window.width * 0.5 / 2, startAngle: .degrees(180), endAngle: .degrees(135), clockwise: true)
        return path
    }
}

struct NauticalDusk: Shape {
    var window: CGSize
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: window.width * 0.5 / 2, startAngle: .degrees(180), endAngle: .degrees(150), clockwise: true)
        return path
    }
}

struct CivilDusk: Shape {
    var window: CGSize
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: window.width * 0.5 / 2, startAngle: .degrees(180), endAngle: .degrees(165), clockwise: true)
        return path
    }
}

