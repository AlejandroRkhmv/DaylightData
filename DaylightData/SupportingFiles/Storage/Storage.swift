//
//  Storage.swift
//  DaylightData
//
//  Created by Александр Рахимов on 07.04.2023.
//

import Foundation
import Combine

protocol StorageProtocol: ObservableObject {
    var isDataUpdate: Bool { get set }
    var cityName: String { get set }
    var sunTime: SunTime? { get set }
    func fillSunTime(from sunTime: SunTime)
    func returnSunTime() -> SunTime?
}

class StorageSunTime: StorageProtocol {
    
    static let shared = StorageSunTime()
    private init() { }
    
    @Published var isDataUpdate: Bool = false {
        didSet {
            let isUpdateStorage = ["updateStorage": isDataUpdate]
            let notification = NotificationCenter.default
            notification.post(name: Notification.Name("isDataUpdate"), object: nil, userInfo: isUpdateStorage)
        }
    }
    @Published var cityName: String = "" {
        didSet {
            print(cityName)
        }
    }
    
    internal var sunTime: SunTime? {
        didSet {
            self.isDataUpdate = true
        }
    }
    
    
    
    func fillSunTime(from sunTime: SunTime) {
        self.sunTime = sunTime
    }
    
    func returnSunTime() -> SunTime? {
        return self.sunTime
    }
}
