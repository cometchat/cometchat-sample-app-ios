//
//  AppDelegate.swift
//  CometChatUI
//
//  Created by Admin1 on 15/11/18.
//  Copyright © 2018 Admin1. All rights reserved.
//

import UIKit
import CometChatPro

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
   

    var window: UIWindow?
 
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       
        self.initialization()

        if((UserDefaults.standard.object(forKey: "LoggedInUserUID")) != nil){
            
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            
            let viewController = storyBoard.instantiateViewController(withIdentifier: "embeddedViewContrroller") as! EmbeddedViewController
            self.window?.rootViewController = viewController
            self.window?.makeKeyAndVisible()
        }
        
        UIFont.overrideInitialize()
        
        switch AppAppearance{
            
        case .AzureRadiance:
            break
        case .MountainMeadow:
            break
        case .PersianBlue:
            
            application.statusBarStyle = .lightContent
            UINavigationBar.appearance().isTranslucent = false
            UINavigationBar.appearance().backgroundColor = .clear
            
        case .Custom:
            break
        }
        return true
    }
    
    func initialization(){
        CometChat(appId: AuthenticationDict?["APP_ID"] as! String, onSuccess: { (Success) in
            print("initialization Success")
            
        }) { (error) in
            print("Initialization Error \(error.errorDescription)")
        }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
        CometChat.startServices()
        
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
      
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
       
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
       
    }


    func applicationWillTerminate(_ application: UIApplication) {
       
    }
    
}



    



