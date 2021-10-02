//
//  text_to_speechApp.swift
//  text_to_speech
//
//  Created by Кирилл on 15.09.2021.
//

import SwiftUI
import ApphudSDK
import UserNotifications

@main
struct text_to_speechApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var viewRouter = ViewRouter()
    
    var body: some Scene {
        WindowGroup {
            MotherView(viewRouter: viewRouter)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        //Apphud.enableDebugLogs()
        Apphud.start(apiKey: "app_RMYhcL5FgT7pXEaC1hZ2eyuJUUJT6g")
        registerForNotifications()
        return true
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Apphud.submitPushNotificationsToken(token: deviceToken, callback: nil)
    }
}

func registerForNotifications(){
   // UNUserNotificationCenter.current().delegate = self
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])    { (granted, error) in
        // handle if needed
    }
    UIApplication.shared.registerForRemoteNotifications()
    let content = UNMutableNotificationContent()
    content.title = "Get Text into Speech!"
    content.sound = UNNotificationSound.default

    // show this notification five seconds from now
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 4 * 3600, repeats: true)

    // choose a random identifier
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    // add our notification request
    if (!Apphud.hasActiveSubscription())
    {
        UNUserNotificationCenter.current().add(request)
    }
}
