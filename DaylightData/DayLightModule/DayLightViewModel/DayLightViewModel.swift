//
//  DaiLightViewModel.swift
//  DaylightData
//
//  Created by Александр Рахимов on 07.04.2023.
//

import Foundation
import Combine
import CoreLocation

protocol DaiLightViewModelProtocol: ObservableObject {
    var storage: (any StorageProtocol)? { get set }
    init(networkService: NetworkServiceProtocol, storage: any StorageProtocol)
    
    func getSunTime()
}

class DayLightViewModel: NSObject, DaiLightViewModelProtocol, CLLocationManagerDelegate {
    
    var networkService: NetworkServiceProtocol!
    var storage: (any StorageProtocol)?
    private var locationManager: CLLocationManager!
    private var currentLocation = Location(latitude: "", longitude: "")
    @Published var isDataUpdate = false
    private var firstTimeAppear = true
    
    required init(networkService: NetworkServiceProtocol = NetworkService(), storage: any StorageProtocol = StorageSunTime.shared) {
        super.init()
        self.networkService = networkService
        self.storage = storage
        self.initLocationManager()
        self.notificationsObserverWithUserInfo()
    }
    
    // MARK: - get sun times for phone position
    internal func getSunTime() {
        
        self.firstTimeAppear = false
        
        networkService.getSunTimeFromTheInternet(latitude: currentLocation.latitude, longitude: currentLocation.longitude, date: currentDate()) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async { [weak self] in
                switch result {
                case.success(let sunTime):
                    guard let self = self,
                          let sunTime = sunTime else { return }
                    self.storage?.fillSunTime(from: sunTime)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - init location manager which get phone position
    fileprivate func initLocationManager() {
        locationManager = CLLocationManager()
        
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                self.locationManager.requestAlwaysAuthorization()
                DispatchQueue.main.async {
                    self.locationManager.startUpdatingLocation()
                }
            } else {
                print("not enabled")
            }
        }
    }
    
    //MARK: - location delegate methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if firstTimeAppear {
        let userLocation: CLLocation = locations[0] as CLLocation
        currentLocation.latitude = "\(userLocation.coordinate.latitude)"
        currentLocation.longitude = "\(userLocation.coordinate.longitude)"
        
    // MARK: - convert location to city and country name
        userLocation.fetchCityAndCountry { [weak self] city, country, error in
            guard let self = self else { return }
            guard let city = city, let country = country, error == nil else { return }
            self.storage?.cityName = city + ", " + country
        }
        
        
            getSunTime()
        }
    }
    
    // MARK: - convert date to need string format
    fileprivate func currentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: Date())
    }
}

// MARK: - notification observer which observed change storages values
extension DayLightViewModel {
    private func notificationsObserverWithUserInfo() {
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(actionAfterNotification), name: Notification.Name("isDataUpdate"), object: nil)
    }
    
    @objc private func actionAfterNotification(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let isDataUpdate = userInfo["updateStorage"] as? Bool else { return }
        self.isDataUpdate = isDataUpdate
    }
}

//MARK: - convert coordinates to city name and country
extension CLLocation {
    func fetchCityAndCountry(completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.country, $1) }
    }
}
