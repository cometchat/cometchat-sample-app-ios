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
        if(Constants.appId.contains(NSLocalizedString("Enter", comment: "")) || Constants.appId.contains(NSLocalizedString("ENTER", comment: "")) || Constants.appId.contains("NULL") || Constants.appId.contains("null") || Constants.appId.count == 0){

          
        }else{
            let appSettings = AppSettings.AppSettingsBuilder().subscribePresenceForAllUsers().setRegion(region: Constants.region).build()
            
         let _ =  CometChat.init(appId:Constants.appId, appSettings: appSettings, onSuccess: { (Success) in
                print( "Initialization onSuccess \(Success)")
                CometChat.setSource(resource: "ui-kit", platform: "ios", language: "swift")
            }) { (error) in
                print( "Initialization Error \(error.errorDescription)")
            }
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        self.initialization()
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        self.initialization()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        self.initialization()
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

