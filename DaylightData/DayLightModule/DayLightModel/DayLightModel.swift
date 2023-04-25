//
//  DayLightModel.swift
//  DaylightData
//
//  Created by Александр Рахимов on 07.04.2023.
//

import Foundation

struct DayLightModel: Codable {
    var results: ResultSunTime?
    let status: String?
}

struct ResultSunTime: Codable {
    let sunrise, sunset, solarNoon, dayLength: String
    let civilTwilightBegin, civilTwilightEnd, nauticalTwilightBegin, nauticalTwilightEnd: String
    let astronomicalTwilightBegin, astronomicalTwilightEnd: String

    enum CodingKeys: String, CodingKey {
        case sunrise, sunset
        case solarNoon = "solar_noon"
        case dayLength = "day_length"
        case civilTwilightBegin = "civil_twilight_begin"
        case civilTwilightEnd = "civil_twilight_end"
        case nauticalTwilightBegin = "nautical_twilight_begin"
        case nauticalTwilightEnd = "nautical_twilight_end"
        case astronomicalTwilightBegin = "astronomical_twilight_begin"
        case astronomicalTwilightEnd = "astronomical_twilight_end"
    }
}

class SunTime {
    var sunrise: String
    var sunset: String
    var solarNoon: String
    var dayLength: String
    var civilTwilightBegin: String
    var civilTwilightEnd: String
    var nauticalTwilightBegin: String
    var nauticalTwilightEnd: String
    var astronomicalTwilightBegin: String
    var astronomicalTwilightEnd: String
    
    init(dayLightModel: DayLightModel) {
        self.sunset = dayLightModel.results!.sunset
        self.sunrise = dayLightModel.results!.sunrise
        self.solarNoon = dayLightModel.results!.solarNoon
        self.dayLength = dayLightModel.results!.dayLength
        self.civilTwilightBegin = dayLightModel.results!.civilTwilightBegin
        self.civilTwilightEnd = dayLightModel.results!.civilTwilightEnd
        self.nauticalTwilightBegin = dayLightModel.results!.nauticalTwilightBegin
        self.nauticalTwilightEnd = dayLightModel.results!.nauticalTwilightEnd
        self.astronomicalTwilightBegin = dayLightModel.results!.astronomicalTwilightBegin
        self.astronomicalTwilightEnd = dayLightModel.results!.astronomicalTwilightEnd
    }
}
