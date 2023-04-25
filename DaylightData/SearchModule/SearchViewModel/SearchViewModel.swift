//
//  SearchViewModel.swift
//  DaylightData
//
//  Created by Александр Рахимов on 11.04.2023.
//

import Foundation
import CoreLocation

protocol SearchViewModelProtocol {
    var networkService: NetworkServiceProtocol! { get set }
    var storage: (any StorageProtocol)? { get set }
    
    init(networkService: NetworkServiceProtocol, storage: any StorageProtocol)
    
    func getSunTime(latitude: String, longitude: String, date: String)
    func getSunTime(city: String, date: String)
}

class SearchViewModel: SearchViewModelProtocol {
    
    var networkService: NetworkServiceProtocol!
    var storage: (any StorageProtocol)?

    
    required init(networkService: NetworkServiceProtocol = NetworkService(), storage: any StorageProtocol = StorageSunTime.shared) {
        self.networkService = networkService
        self.storage = storage
    }
    
    // MARK: - function for coordinatesView
    func getSunTime(latitude: String, longitude: String, date: String) {
        
        // MARK: - update value in view model to update SunTimeView
        self.storage?.isDataUpdate = false
        
        // MARK: - convert location to city and country name
        let userLocation = CLLocation(latitude: CLLocationDegrees(Double(latitude)!), longitude: CLLocationDegrees(Double(longitude)!))
        userLocation.fetchCityAndCountry { [weak self] city, country, error in
            guard let self = self else { return }
            guard let city = city, let country = country, error == nil else { return }
            self.storage?.cityName = city + ", " + country
        }
        
        // MARK: - network function get times
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.networkService.getSunTimeFromTheInternet(latitude: latitude, longitude: longitude, date: self.userDate(userEnteredDate: date)) { [weak self] result in
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
    }
    
    // MARK: - function for cityView
    func getSunTime(city: String, date: String) {
        
        // MARK: - update value in view model to update SunTimeView
        self.storage?.isDataUpdate = false
        
        // MARK: - return coordinate from city and country user
        getCoordinateFrom(address: city) { coordinate, error in
            guard let coordinate = coordinate, error == nil else { return }
            
            // MARK: - convert location to city and country name
            let userLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
                userLocation.fetchCityAndCountry { [weak self] city, country, error in
                    guard let self = self else { return }
                    guard let city = city, let country = country, error == nil else { return }
                    self.storage?.cityName = city + ", " + country
                }
            
            // MARK: - network function get times
            DispatchQueue.global().async { [weak self] in
                guard let self = self else { return }
                self.networkService.getSunTimeFromTheInternet(latitude: String(coordinate.latitude), longitude: String(coordinate.longitude), date: self.userDate(userEnteredDate: date)) { [weak self] result in
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
        }
    }
    
    //MARK: - convert from city name to lalitude longitude
    fileprivate func getCoordinateFrom(address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
        CLGeocoder().geocodeAddressString(address) { completion($0?.first?.location?.coordinate, $1) }
    }
    
    // MARK: - convert user date to need format
    fileprivate func userDate(userEnteredDate: String) -> String {
        var date = ""
        let day = userEnteredDate.components(separatedBy: ".")[0]
        let month = userEnteredDate.components(separatedBy: ".")[1]
        let year = userEnteredDate.components(separatedBy: ".")[2]
        date = year + "-" + month + "-" + day
        return date
    }
}
