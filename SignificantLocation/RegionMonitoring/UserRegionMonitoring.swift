//
//  PromiximityGeographicRegionsMonitoring.swift
//  SignificantLocation
//
//  Created by João Macedo on 12/05/23.
//

import Foundation
import CoreLocation

class UserRegionMonitoring: NSObject {
    public static var instance: UserRegionMonitoring { userRegionMonitoring }
    private static let userRegionMonitoring = UserRegionMonitoring()

    private let locationManager: CLLocationManager
    private let regionDAO: RegionLogDAO
    
    init(locationManager: CLLocationManager? = nil, regionDAO: RegionLogDAO? = nil) {
        self.locationManager = locationManager ?? CLLocationManager()
        self.regionDAO = regionDAO ?? RegionLogDAO.instance
    }
    
    public func startRegionMonitoring(radius: Double? = nil) {
        guard let currentLocation: CLLocationCoordinate2D = getCurrentLocation() else { return }
        
        guard let region = buildMonitoringRegion(
            centerCoordinates: currentLocation,
            identifier: "CircularRegion",
            radius: radius
        ) else { return }
        
        locationManager.requestAlwaysAuthorization()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.showsBackgroundLocationIndicator = true

        print("Inicia monitoramento")
        locationManager.startMonitoring(for: region)
    }
    
    public func stopMonitoringRegion(region: CLCircularRegion) {
        locationManager.stopMonitoring(for: region)
    }
    
    public func stopMonitoringAllRegions() {
        print("Interrompe todos os monitoramentos")
        let regions = locationManager.monitoredRegions
        
        for region in regions {
            locationManager.stopMonitoring(for: region)
        }
    }
    
    public func cleanRegionLogs() {
        regionDAO.regionLogs = []
        regionDAO.storeRegionsLogs()
    }
    
    private func buildMonitoringRegion(centerCoordinates: CLLocationCoordinate2D, identifier: String, radius: Double? = nil) -> CLCircularRegion? {
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            let maxDistance = radius ?? locationManager.maximumRegionMonitoringDistance
            let region = CLCircularRegion(
                center: centerCoordinates,
                radius: maxDistance,
                identifier: identifier
            )
            
            region.notifyOnEntry = true
            region.notifyOnExit = true
            
            print(maxDistance)
            print(centerCoordinates)
            
            return region
        }
        return nil
    }
    
    private func getCurrentLocation() -> CLLocationCoordinate2D? {
        return locationManager.location?.coordinate
    }
}

// MARK: -> LocationDelegate
// Os métodos de monitoramento de região só serão chamados se o usuário permanecer 20 segundos no ambiente alterado para evitar chamadas falsas
// Máximo de 20 regiões simultaneas de observação, passando disso, o sistema irá escolher as 20 mais próximas

extension UserRegionMonitoring: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Usuário entrou da região")
        
        NotificationHandler.instance.sendLocalNotification(
            title: "Evento: \(Date())",
            subtitle: "Você entrou na regiao",
            timeInterval: 5.0
        )
        regionDAO.add(newRegionLog: RegionLog(moment: Date(), isInsideOfRegion: true))
        regionDAO.storeRegionsLogs()
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Usuário saiu da região")
        
        NotificationHandler.instance.sendLocalNotification(
            title: "Evento: \(Date())",
            subtitle: "Você saiu na regiao",
            timeInterval: 5.0
        )
        
        regionDAO.add(newRegionLog: RegionLog(moment: Date(), isInsideOfRegion: false))
        regionDAO.storeRegionsLogs()
    }
}
