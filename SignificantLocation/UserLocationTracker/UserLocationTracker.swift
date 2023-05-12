//
//  UserLocationTracker.swift
//  FullArm
//
//  Created by João Macedo on 03/05/23.
//  Copyright © 2023 Fulltime Gestora de Dados. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class UserLocationTracker: NSObject, CLLocationManagerDelegate {
    
    private static let userLocationTracker = UserLocationTracker()
    
    public static var instance: UserLocationTracker { userLocationTracker }
    
    private let locationManager: CLLocationManager
    private let notificationHandler: NotificationHandler
    
    init(locationManager: CLLocationManager? = nil, notificationHandler: NotificationHandler? = nil) {
        self.locationManager = locationManager ?? CLLocationManager()
        self.notificationHandler = notificationHandler ?? NotificationHandler()
    }
    
    public func initializeLocationTracker() {
        locationManager.delegate = self
        
        locationManager.requestAlwaysAuthorization()
        if (locationManager.authorizationStatus == .denied || locationManager.authorizationStatus == .notDetermined) { return }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.activityType = .other
        locationManager.startMonitoringSignificantLocationChanges()
        print("Coleta de localização irá iniciar")
    }
    
    public func finishLocationTracker() {
        print("Coleta de localização irá ser interrompida")
        locationManager.stopMonitoringSignificantLocationChanges()
    }
    
    
    // Informa todas as alterações significantes de localização
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let coordinates = locations.first?.coordinate
        
        let location = Location(latitude: "\(String(describing: coordinates?.latitude))", longitude: "\(String(describing: coordinates?.latitude))")
        
        LocationDAO.instance.addNewLocation(newLocation: location)
        LocationDAO.instance.storeLocations()
        
        print("Atualização de localização às \(Date()))")
        print("\(String(describing: coordinates))")
        
        self.notificationHandler.sendLocalNotification(
            title: "\(Date()))",
            subtitle: "Latitude: \(coordinates?.latitude ?? 0) Longitude: \(coordinates?.longitude ?? 0) ",
            notificationSound: .default,
            timeInterval: 5.0
        )
    }
    
    // Informa quando alterações de localização não serão mais chamadas
    func locationManager(_ manager: CLLocationManager, didFinishDeferredUpdatesWithError error: Error?) {
        print("Erro na atualização de localização às \(Date()))")
        print("\(String(describing: error))")
        
        self.notificationHandler.sendLocalNotification(
            title: "Atualização de localização às \(Date()))",
            subtitle: "Erros ou motivação de acabar os registros: \(String(describing: error))",
            notificationSound: .default,
            timeInterval: 5.0
        )
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Erro na atualização de localização às \(Date()))")
        print("\(String(describing: error))")
        
        self.notificationHandler.sendLocalNotification(
            title: "Atualização de localização às \(Date()))",
            subtitle: "Erros ou motivação de acabar os registros: \(String(describing: error))",
            notificationSound: .default,
            timeInterval: 5.0
        )
    }
    
    public func cleanLocations() {
        LocationDAO.instance.cleanLocations()
    }
    
    public func storeLocations() {
        LocationDAO.instance.storeLocations()
    }
    
    public func getLocations() -> [Location] {
        return LocationDAO.instance.getLocations()
    }
    
}
