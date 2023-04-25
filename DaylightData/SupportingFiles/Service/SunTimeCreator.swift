//
//  SunTimeCreator.swift
//  DaylightData
//
//  Created by Александр Рахимов on 08.04.2023.
//

import Foundation

class SunTimeCreator {
    func createSunTimeObject(object: DayLightModel) -> SunTime {
        let sunTimeObject = SunTime(dayLightModel: object)
        sunTimeObject.astronomicalTwilightBegin = from(time12to24: sunTimeObject.astronomicalTwilightBegin)
        sunTimeObject.nauticalTwilightBegin = from(time12to24: sunTimeObject.nauticalTwilightBegin)
        sunTimeObject.civilTwilightBegin = from(time12to24: sunTimeObject.civilTwilightBegin)
        sunTimeObject.sunrise = from(time12to24: sunTimeObject.sunrise)
        sunTimeObject.solarNoon = from(time12to24: sunTimeObject.solarNoon)
        sunTimeObject.sunset = from(time12to24: sunTimeObject.sunset)
        sunTimeObject.civilTwilightEnd = from(time12to24: sunTimeObject.civilTwilightEnd)
        sunTimeObject.nauticalTwilightEnd = from(time12to24: sunTimeObject.nauticalTwilightEnd)
        sunTimeObject.astronomicalTwilightEnd = from(time12to24: sunTimeObject.astronomicalTwilightEnd)
        return sunTimeObject
    }
    
    fileprivate func from(time12to24 time: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm:ss a"

        guard let date = dateFormatter.date(from: time) else { return "" }
            dateFormatter.dateFormat = "HH:mm"
            
            let time24 = dateFormatter.string(from: date)
        return utcToLocal(dateStr: time24)
    }
    
    fileprivate func utcToLocal(dateStr: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = dateFormatter.date(from: dateStr) {
            dateFormatter.timeZone = TimeZone.autoupdatingCurrent
            dateFormatter.dateFormat = "HH:mm"
            let localTime = dateFormatter.string(from: date)
            return localTime
        }
        return ""
    }
}
