//
//  MoonView.swift
//  DaylightData
//
//  Created by Александр Рахимов on 01.04.2023.
//

import SwiftUI

struct MoonView: View {
    
    var progress: Double
    
    init(progress: Double) {
        self.progress = progress
    }
    
    var body: some View {
        Moon(progress: progress)
            .foregroundColor(Color(ColorEnum.darkShadow.rawValue))
            .shadow(color: Color(ColorEnum.darkShadow.rawValue), radius: 2, x: 0, y: 0)
            .shadow(color: Color(ColorEnum.text.rawValue), radius: 3, x: 0, y: 0)
    }
}

struct MoonView_Previews: PreviewProvider {
    static var previews: some View {
        MoonView(progress: 1.0)
    }
}

struct Moon: View {
    
    var progress: Double
    
    init(progress: Double) {
        self.progress = progress
    }
    
    var body: some View {
        ZStack {
            HalfMoon()
                .opacity(progress * 2.5)
            BigStar()
                .offset(x: -30, y: -15)
                .modifierForStars(progress: progress, multiplayer: 0.8)
            SmallStar()
                .offset(x: -15)
                .modifierForStars(progress: progress, multiplayer: 1)
            LongStar()
                .offset(x: -10, y: -25)
                .modifierForStars(progress: progress, multiplayer: 1.5)
            BlickMoon()
                .fill(Color(ColorEnum.blik.rawValue))
                .opacity(progress)
            Rectangle()
                .frame(width: 4, height: 4)
                .offset(x: 23, y: -7)
                .foregroundColor(Color(ColorEnum.blik.rawValue))
                .modifierForStars(progress: progress, multiplayer: 1.5)
            Rectangle()
                .frame(width: 4, height: 4)
                .offset(x: 23, y: 4)
                .foregroundColor(Color(ColorEnum.blik.rawValue))
                .modifierForStars(progress: progress, multiplayer: 1.3)
        }
    }
}

struct HalfMoon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.midY - 30))
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: 30, startAngle: .degrees(270), endAngle: .degrees(150), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX - 10, y: rect.midY - 8.5), radius: 25, startAngle: .degrees(150), endAngle: .degrees(300), clockwise: true)
        return path
    }
}


struct BigStar: View {
    var body: some View {
        ZStack {
            HalfStar()
            HalfStar()
                .rotationEffect(.degrees(90))
        }
    }
}

struct HalfStar: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.midY + 10))
        path.addLine(to: CGPoint(x: rect.midX + 3, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY - 10))
        path.addLine(to: CGPoint(x: rect.midX - 3, y: rect.midY))
        return path
    }
}

struct SmallStar: View {
    var body: some View {
        ZStack {
            HalfSmallStar()
            HalfSmallStar()
                .rotationEffect(.degrees(90))
        }
    }
}

struct HalfSmallStar: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.midY + 7))
        path.addLine(to: CGPoint(x: rect.midX + 3, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY - 7))
        path.addLine(to: CGPoint(x: rect.midX - 3, y: rect.midY))
        return path
    }
}

struct LongStar: View {
    var body: some View {
        ZStack {
            HalfLongStar()
            HalfLongStar()
                .rotationEffect(.degrees(90))
        }
    }
}

struct HalfLongStar: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.midY + 15))
        path.addLine(to: CGPoint(x: rect.midX + 2, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY - 15))
        path.addLine(to: CGPoint(x: rect.midX - 2, y: rect.midY))
        return path
    }
}

struct BlickMoon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX + 21, y: rect.midY + 12))
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: 25, startAngle: .degrees(30), endAngle: .degrees(90), clockwise: false)
        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY + 21))
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: 21, startAngle: .degrees(90), endAngle: .degrees(30), clockwise: true)
        return path
    }
}


struct ProgressModifierForStars: ViewModifier {
    
    var progress: Double
    var multiplayer: Double
    
    init(progress: Double, multiplayer: Double) {
        self.progress = progress
        self.multiplayer = multiplayer
    }
    
    func body(content: Content) -> some View {
        content
            .opacity(progress / multiplayer)
    }
}

extension View {
    func modifierForStars(progress: Double, multiplayer: Double) -> some View {
        modifier(ProgressModifierForStars(progress: progress, multiplayer: multiplayer))
    }
}
