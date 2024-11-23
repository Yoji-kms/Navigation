//
//  LocalNotificationService.swift
//  Navigation
//
//  Created by Yoji on 23.11.2024.
//

import UIKit
import UserNotifications

final class LocalNotificationService: NSObject {
    private let notificationCenter = UNUserNotificationCenter.current()
    
    private enum Constants {
        case categoryId
        case actionId
        case userInfoKey
        
        var string: String {
            switch self {
            case .categoryId:
                "updates"
            case .actionId:
                "action"
            case .userInfoKey:
                "key"
            }
        }
    }
    
    func registerForLatestUpdatesIfPossible() {
        self.registerUpdatesCategory()
        Task {
            let authorizationStatus = await self.notificationCenter.notificationSettings().authorizationStatus
            if authorizationStatus == .notDetermined {
                self.requestAuthorization() { [weak self] in
                    guard let self else { return }
                    try await self.addNotification()
                }
            } else if authorizationStatus == .authorized {
                self.notificationCenter.removeAllPendingNotificationRequests()
                try await self.addNotification()
            }
        }
        
    }
    
    private func addNotification() async throws {
        let content = UNMutableNotificationContent()
        
        content.body = "Watch last updates".localized
        content.sound = .default
        content.categoryIdentifier = Constants.categoryId.string
        content.userInfo = [Constants.userInfoKey.string: "Some user info"]
        
        let dateComponents = DateComponents(calendar: Calendar.current, hour: 21, minute: 44)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let notificationRequest = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        try await self.notificationCenter.add(notificationRequest)
    }
    
    private func requestAuthorization(completion: @escaping () async throws ->Void) {
        let options = UNAuthorizationOptions([.sound, .badge, .alert])
        self.notificationCenter.requestAuthorization(options: options) { result, _ in
            if result {
                Task {
                    try await completion()
                }
            }
        }
    }
    
    private func registerUpdatesCategory() {
        self.notificationCenter.delegate = self
        let action = UNNotificationAction(identifier: Constants.actionId.string, title: "action".localized)
        
        let category = UNNotificationCategory(identifier: Constants.categoryId.string, actions: [action], intentIdentifiers: [])
        self.notificationCenter.setNotificationCategories([category])
    }
}

extension LocalNotificationService: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.actionIdentifier == Constants.actionId.string {
            guard let userInfo = response.notification.request.content.userInfo[Constants.userInfoKey.string] else {
                completionHandler()
                return
            }
            print(userInfo)
        }
        completionHandler()
    }
}
