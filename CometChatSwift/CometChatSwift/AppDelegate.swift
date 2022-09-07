//
//  AppDelegate.swift
//  Demo
//
//  Created by CometChat Inc. on 16/12/19.
//  Copyright © 2020 CometChat Inc. All rights reserved.
//

import UIKit
import CometChatPro


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.initialization()
        
        CometChatCallManager().registerForCalls(application: self)
        
        if CometChat.getLoggedInUser() != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainVC = storyboard.instantiateViewController(withIdentifier: "mainViewController") as! MainViewController
            let navigationController: UINavigationController = UINavigationController(rootViewController: mainVC)
            navigationController.modalPresentationStyle = .fullScreen
            navigationController.title = "CometChat KitchenSink"
            navigationController.navigationBar.prefersLargeTitles = true
            if #available(iOS 13.0, *) {
                let navBarAppearance = UINavigationBarAppearance()
                navBarAppearance.configureWithOpaqueBackground()
                navBarAppearance.titleTextAttributes = [ .foregroundColor:  UIColor.label,.font: UIFont.boldSystemFont(ofSize: 20) as Any]
                navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label, .font: UIFont.boldSystemFont(ofSize: 30) as Any]
                navBarAppearance.shadowColor = .clear
                navBarAppearance.backgroundColor = .systemBackground
                navigationController.navigationBar.standardAppearance = navBarAppearance
                navigationController.navigationBar.scrollEdgeAppearance = navBarAppearance
                navigationController.navigationBar.isTranslucent = false
            }
            self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()
        }
        return true
    }
    
    func initialization(){
        if(Constants.appId.contains("Enter") || Constants.appId.contains("ENTER") || Constants.appId.contains("NULL") || Constants.appId.contains("null") || Constants.appId.count == 0){
            
            
        }else{
            let appSettings = AppSettings.AppSettingsBuilder().subscribePresenceForAllUsers().setRegion(region: Constants.region).build()
            
            let _ =  CometChat.init(appId:Constants.appId, appSettings: appSettings, onSuccess: { (Success) in
                print( "Initialization onSuccess \(Success)")
                CometChat.setSource(resource: "ui-kit", platform: "ios", language: "swift")
                
                
            }) { (error) in
                print( "Initialization Error Code:  \(error.errorCode)")
                print( "Initialization Error Description:  \(error.errorDescription)")
            }
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        CometChat.configureServices(.willResignActive)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        CometChat.configureServices(.didEnterBackground)
    }
    
    
    func applicationWillTerminate(_ application: UIApplication) {
       
    }
}

