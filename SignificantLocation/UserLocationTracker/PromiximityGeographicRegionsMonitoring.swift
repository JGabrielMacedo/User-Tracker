//
//  PromiximityGeographicRegionsMonitoring.swift
//  SignificantLocation
//
//  Created by João Macedo on 12/05/23.
//

import Foundation
import CoreLocation

class PromiximityGeographicRegionsMonitoring: NSObject, CLLocationManagerDelegate {
    let locationManager: CLLocationManager
    
    init(locationManager: CLLocationManager? = nil) {
        self.locationManager = locationManager ?? CLLocationManager()
    }
    
    public func monitorRegionAtLocation(centerCoordinates: CLLocationCoordinate2D, identifier: String ) {
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            
            let maxDistance = locationManager.maximumRegionMonitoringDistance
            let region = CLCircularRegion(
                center: centerCoordinates,
                radius: maxDistance,
                identifier: identifier
            )
            
            region.notifyOnEntry = true
            region.notifyOnExit = true
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.allowsBackgroundLocationUpdates = true
            locationManager.startMonitoring(for: region)
        }
    }
    
    public func stopMonitoringRegion(region: CLCircularRegion) {
        locationManager.stopMonitoring(for: region)
    }
    
    public func stopMonitoringAllRegions() {
        let regions = locationManager.monitoredRegions
        
        for region in regions {
            locationManager.stopMonitoring(for: region)
        }
    }
    
    // Os métodos de monitoramento de região só serão chamados se o usuário permanecer 20 segundos no ambiente alterado para evitar chamadas falsas
    // Máximo de 20 regiões simultaneas de observação, passando disso, o sistema irá escolher as 20 mais próximas
    
    // MARK: -> Fencing monitoring methods
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Usuário entrou na região")
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Usuário saiu da região")
    }
}
