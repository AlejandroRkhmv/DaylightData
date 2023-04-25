//
//  NetworkService.swift
//  DaylightData
//
//  Created by Александр Рахимов on 07.04.2023.
//

import Foundation

protocol NetworkServiceProtocol: AnyObject {
    
    func getSunTimeFromTheInternet(latitude: String, longitude: String, date: String, complition: @escaping (Result<SunTime?, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    private let sunTimeCreator = SunTimeCreator()
    
    func getSunTimeFromTheInternet(latitude: String, longitude: String, date: String, complition: @escaping (Result<SunTime?, Error>) -> Void) {
        
        let urlString = "https://api.sunrise-sunset.org/json?lat=\(latitude)&lng=\(longitude)&date=\(date)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            if let errorCome = error {
                complition(.failure(errorCome))
                return
            }
            
            do {
                guard let dataWasCome = data else { return }
                let responseObject = try JSONDecoder().decode(DayLightModel.self, from: dataWasCome)
                let sunTime = self.sunTimeCreator.createSunTimeObject(object: responseObject)
                complition(.success(sunTime))
            } catch {
                complition(.failure(error))
            }
        }.resume()
    }
}
