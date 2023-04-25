//
//  CurrentDateView.swift
//  DaylightData
//
//  Created by Александр Рахимов on 01.04.2023.
//

import SwiftUI

struct CurrentDateView : View {
    
    @State var newDate = Date()
    let timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()

    var body: some View {
        VStack(alignment: .leading) {
            Text("Weekday: \(weekDay(from:newDate))")
                .onReceive(timer) { _ in
                    self.newDate = Date()
                }
            Text("Date: \(date(from:newDate))")
                .onReceive(timer) { _ in
                    self.newDate = Date()
                }
            Text("\(timeZone()): \(time(from:newDate))")
                .onReceive(timer) { _ in
                    self.newDate = Date()
                }
            Text("UTC: \(utcTime(from:newDate))")
                .onReceive(timer) { _ in
                    self.newDate = Date()
                }
        }
        .font(.system(size: 12))
        .foregroundColor(Color(ColorEnum.color.rawValue))
        .shadow(color: Color(ColorEnum.darkShadow.rawValue), radius: 2, x: 0, y: 0)
        .shadow(color: Color(ColorEnum.text.rawValue), radius: 3, x: 0, y: 0)
    }
    
    func date(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: date)
    }
    
    func time(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: date)
    }
    
    func weekDay(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
    
    func utcTime(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.string(from: date)
    }
    
    private func timeZone() -> String {
        return TimeZone.current.localizedName(for: .shortGeneric, locale: .current)!
    }
}

struct timer_Previews: PreviewProvider {
    static var previews: some View {
        CurrentDateView()
    }
}
