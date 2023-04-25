//
//  SunView.swift
//  DaylightData
//
//  Created by Александр Рахимов on 31.03.2023.
//

import SwiftUI

struct SunView: View {
    
    var progress: Double
    
    init(progress: Double) {
        self.progress = progress
    }
    
    var body: some View {
            Sun(progress: progress)
            .foregroundColor(Color(ColorEnum.color.rawValue))
            .shadow(color: Color(ColorEnum.darkShadow.rawValue), radius: 2, x: 0, y: 0)
            .shadow(color: Color(ColorEnum.text.rawValue), radius: 3, x: 0, y: 0)
    }
}

struct SunView_Previews: PreviewProvider {
    static var previews: some View {
        SunView(progress: 1.0)
    }
}

struct Sun: View {
    
    var progress: Double
    
    init(progress: Double) {
        self.progress = progress
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 1) {
                Up(progress: progress)
                HStack(spacing: 1) {
                    Left(progress: progress)
                    SunDisk()
                        .frame(width: 90, height: 90)
                        .opacity(1 - progress * 2.5)
                    Left(progress: progress)
                        .rotationEffect(.degrees(180))
                }
                Up(progress: progress)
                    .rotationEffect(.degrees(180))
            }
            BlickSun()
                .fill(Color(ColorEnum.blik.rawValue))
                .opacity(1 - progress * 7)
        }
    }
}

struct SunDisk: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.midY))
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: 25, startAngle: .zero, endAngle: .degrees(360), clockwise: true)
        return path
    }
}

struct LongRay: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 2.5)
            .frame(width: 5, height: 30, alignment: .center)
    }
}

struct ShortRay: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 2.5)
            .frame(width: 5, height: 20, alignment: .center)
    }
}

struct BlickSun: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.midY - 19))
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: 19, startAngle: .degrees(270), endAngle: .zero, clockwise: false)
        path.addLine(to: CGPoint(x: rect.midX + 20, y: rect.midY))
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: 15, startAngle: .zero, endAngle: .degrees(270), clockwise: true)
        return path
    }
}

struct Up: View {
    
    var progress: Double
    
    init(progress: Double) {
        self.progress = progress
    }
    
    var body: some View {
        HStack {
            LongRay()
                .rotationEffect(.degrees(315))
                .offset(x: -10, y: 30)
                .modifierForRays(progress: progress, multiplayer: 5)
            ShortRay()
                .rotationEffect(.degrees(337.5))
                .offset(x: -6, y: 23)
                .modifierForRays(progress: progress, multiplayer: 6)
            LongRay()
                .offset(x: 0, y: 15)
                .modifierForRays(progress: progress, multiplayer: 8)
            ShortRay()
                .rotationEffect(.degrees(22.5))
                .offset(x: 6, y: 23)
                .modifierForRays(progress: progress, multiplayer: 6)
            LongRay()
                .rotationEffect(.degrees(45))
                .offset(x: 10, y: 30)
                .modifierForRays(progress: progress, multiplayer: 5)
        }
    }
}

struct Left: View {
    
    var progress: Double
    
    init(progress: Double) {
        self.progress = progress
    }
    
    var body: some View {
        VStack(spacing: 1) {
            ShortRay()
                .rotationEffect(.degrees(292.5))
                .offset(x: 8, y: 12)
                .modifierForRays(progress: progress, multiplayer: 6)
            LongRay()
                .rotationEffect(.degrees(90))
                .modifierForRays(progress: progress, multiplayer: 5)
            ShortRay()
                .rotationEffect(.degrees(67.5))
                .offset(x: 8, y: -12)
                .modifierForRays(progress: progress, multiplayer: 6)
        }
    }
}

struct ProgressModifierForRays: ViewModifier {
    
    var progress: Double
    var multiplayer: Int
    
    init(progress: Double, multiplayer: Int) {
        self.progress = progress
        self.multiplayer = multiplayer
    }
    
    func body(content: Content) -> some View {
        content
            .opacity(1 - (progress * Double(multiplayer)))
    }
}

extension View {
    func modifierForRays(progress: Double, multiplayer: Int) -> some View {
        modifier(ProgressModifierForRays(progress: progress, multiplayer: multiplayer))
    }
}
