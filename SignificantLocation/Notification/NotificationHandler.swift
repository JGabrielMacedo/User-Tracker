//
//  NotificationHandler.swift
//  SignificantLocation
//
//  Created by João Macedo on 09/05/23.
//

import Foundation
import UserNotifications


class NotificationHandler {
    
    private static let notificationHandler = NotificationHandler()
    
    public static var instance: NotificationHandler { notificationHandler }
    
    public func hasNotificationPermission(completion: @escaping (UNAuthorizationStatus) -> Void) { UNUserNotificationCenter.current().getNotificationSettings { settings in
        completion(settings.authorizationStatus)
    }
    }
    
    public func requestNotificationAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
                return
            }
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
        }
    }
    
    public func sendLocalNotification(
        title: String? = nil,
        subtitle: String? = nil,
        notificationSound: UNNotificationSound = .default,
        timeInterval: TimeInterval = 5,
        shouldRepet: Bool = false
    ) {
        let content = UNMutableNotificationContent()
        content.title = title ?? ""
        content.subtitle = subtitle ?? ""
        content.sound = notificationSound
        
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: shouldRepet)
        
        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }
}
