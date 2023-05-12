//
//  LocationDAO.swift
//  SignificantLocation
//
//  Created by João Macedo on 12/05/23.
//

import Foundation
class Location: Codable, Identifiable {
    
    init(latitude: String, longitude: String) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    
    let latitude: String
    let longitude: String
    
}

class LocationDAO {
    
    private static var locationDAO = LocationDAO()
    
    public static var instance: LocationDAO { locationDAO }
    
    var locations: [Location] = []
    
    public func addNewLocation(newLocation: Location) {
        locations.append(newLocation)
    }
    
    public func getLocations() -> [Location] {
        do {
            guard let locationsFromUserDefaults: Data = UserDefaults.standard.object(forKey: "locations") as? Data else { return [] }
            
            let locations = try JSONDecoder().decode([Location].self, from: locationsFromUserDefaults)
            return locations
        } catch {
            print("Falha ao buscar localizações")
            return []
        }
    }
    
    public func storeLocations() {
        do {
            let locationsData = try JSONEncoder().encode(locations)
            UserDefaults.standard.set(locationsData, forKey: "locations")
        } catch {
            print("Incapaz de terminar essa ação")
        }
    }
    
    public func cleanLocations() {
        locations = []
        storeLocations()
    }
}
