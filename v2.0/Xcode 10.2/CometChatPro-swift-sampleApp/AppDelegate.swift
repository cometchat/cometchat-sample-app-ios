//
//  AppDelegate.swift
//  CometChatUI
//
//  Created by Pushpsen Airekar on 15/11/18.
//  Copyright © 2018 Pushpsen Airekar. All rights reserved.

import UIKit
import CometChatPro
import LocalAuthentication


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"
    var context = LAContext()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.initialization()
        DispatchQueue.main.async {
            if UserDefaults.standard.object(forKey: "getLanguage") != nil{
                AnyLanguageBundle.setLanguage(UserDefaults.standard.object(forKey: "getLanguage") as! String)
            }
            if((UserDefaults.standard.object(forKey: "LoggedInUserUID")) != nil){
                self.window = UIWindow(frame: UIScreen.main.bounds)
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyBoard.instantiateViewController(withIdentifier: "embeddedViewContrroller") as! EmbeddedViewController
                self.window?.rootViewController = viewController
                self.window?.makeKeyAndVisible()
                UIFont.overrideInitialize()
                
            }
        }
        switch AppAppearance{
        case .AzureRadiance:break
        case .MountainMeadow:break
        case .PersianBlue:
            application.statusBarStyle = .lightContent
            UINavigationBar.appearance().isTranslucent = false
            UINavigationBar.appearance().backgroundColor = .clear
        case .Custom:break }
        
        return true
    }
    
    func initialization(){
        let appSettings = AppSettings.AppSettingsBuilder().subscribePresenceForAllUsers().setRegion(region: AuthenticationDict?["REGION"] as! String).build()
        print("REGION IS: \(AuthenticationDict?["REGION"] as! String)")
        CometChat.init(appId: AuthenticationDict?["APP_ID"] as! String, appSettings: appSettings, onSuccess: { (Success) in
            CometChatLog.print(items: "initialization Success: \(Success)")
        }) { (error) in
            CometChatLog.print(items: "Initialization Error \(error.errorDescription)")
        }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        self.initialization()
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {}
    
    func applicationDidEnterBackground(_ application: UIApplication) {}
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        self.initialization()
    }
    
    
    func applicationWillTerminate(_ application: UIApplication) {}

}

var bundleKey: UInt8 = 0

class AnyLanguageBundle: Bundle {
    
    override func localizedString(forKey key: String,
                                  value: String?,
                                  table tableName: String?) -> String {
        
        guard let path = objc_getAssociatedObject(self, &bundleKey) as? String,
            let bundle = Bundle(path: path) else {
                
                return super.localizedString(forKey: key, value: value, table: tableName)
        }
        
        return bundle.localizedString(forKey: key, value: value, table: tableName)
    }
}

extension Bundle {
    
    class func setLanguage(_ language: String) {
        
        defer {
            
            object_setClass(Bundle.main, AnyLanguageBundle.self)
        }
        
        objc_setAssociatedObject(Bundle.main, &bundleKey,    Bundle.main.path(forResource: language, ofType: "lproj"), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}







