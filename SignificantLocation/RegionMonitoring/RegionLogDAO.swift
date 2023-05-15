//
//  RegionRegistry.swift
//  SignificantLocation
//
//  Created by João Macedo on 15/05/23.
//

import Foundation

class RegionLog: Codable, Identifiable {
    
    init(moment: Date, isInsideOfRegion: Bool) {
        self.moment = moment
        self.isInsideOfRegion = isInsideOfRegion
    }
    
    let moment: Date
    let isInsideOfRegion: Bool
}

class RegionLogDAO {
    
    private static var regionLogDAO = RegionLogDAO()
    
    public static var instance: RegionLogDAO { regionLogDAO }
    
    var regionLogs: [RegionLog] = []
    
    public func add(newRegionLog: RegionLog) {
        regionLogs.append(newRegionLog)
    }
    
    public func getRegionLogs() -> [RegionLog] {
        do {
            guard let regionsFromUserDefaults = UserDefaults.standard.object(forKey: UserDefaultsFields.RegionLogFields.regionsLog) as? Data else { return [] }
            
            let regions = try JSONDecoder().decode([RegionLog].self, from: regionsFromUserDefaults)
            return regions
        } catch {
            print("Falha ao buscar regionsRegistry")
            return []
        }
    }
    
    public func storeRegionsLogs() {
        do {
            let regionsData = try JSONEncoder().encode(regionLogs)
            UserDefaults.standard.set(regionsData, forKey: UserDefaultsFields.RegionLogFields.regionsLog)
        } catch {
            print("Incapaz de terminar essa ação")
        }
    }
    
    public func cleanRegionsLogs() {
        regionLogs = []
        storeRegionsLogs()
    }
}
