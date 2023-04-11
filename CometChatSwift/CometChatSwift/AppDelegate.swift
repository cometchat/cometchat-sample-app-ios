//
//  AppDelegate.swift
//  Demo
//
//  Created by CometChat Inc. on 16/12/19.
//  Copyright © 2020 CometChat Inc. All rights reserved.
//

import UIKit
import CometChatPro
import CometChatUIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
   
    var window: UIWindow?
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
   
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.initialization()
        
    // MARK: - To set default theme, uncommented the commented line.
       CometChatTheme.defaultAppearance()
        let palette = Palette()
        palette.set(background: .purple)
        palette.set(accent: .cyan)
        palette.set(primary: .green)
        palette.set(error: .red)
        palette.set(success: .yellow)
        palette.set(secondary: .orange)
    
        let family = CometChatFontFamily(regular: "CourierNewPSMT", medium: "CourierNewPS-BoldMT", bold: "CourierNewPS-BoldMT")
        var typography = Typography()
        typography.overrideFont(family: family)
        
      //  CometChatTheme(typography: typography, palatte: palette)
        
        if CometChat.getLoggedInUser() != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainVC = storyboard.instantiateViewController(withIdentifier: "home") as! Home
            let navigationController: UINavigationController = UINavigationController(rootViewController: mainVC)
            navigationController.modalPresentationStyle = .fullScreen
            navigationController.navigationBar.prefersLargeTitles = true
           
            if #available(iOS 13.0, *) {
                let navBarAppearance = UINavigationBarAppearance()
                navBarAppearance.configureWithOpaqueBackground()
                navBarAppearance.titleTextAttributes = [ .foregroundColor:  UIColor.label,.font: UIFont.boldSystemFont(ofSize: 20) as Any]
                navBarAppearance.shadowColor = .clear
                navBarAppearance.backgroundColor = .systemGray5
                navigationController.navigationBar.standardAppearance = navBarAppearance
                navigationController.navigationBar.scrollEdgeAppearance = navBarAppearance
                navigationController.navigationBar.isTranslucent = true
            }
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }
        return true
        
       
    }
    
    
    
    func initialization() {
        if(Constants.appId.contains("Enter") || Constants.appId.contains("ENTER") || Constants.appId.contains("NULL") || Constants.appId.contains("null") || Constants.appId.count == 0) {

        } else {
            let uikitSettings = UIKitSettings()
            uikitSettings.set(appID: Constants.appId)
                .set(authKey: Constants.authKey)
                .set(region: Constants.region)
                .subscribePresenceForAllUsers()
                .build()
            
            CometChatUIKit.init(authSettings: uikitSettings, result: {
                result in
                switch result {
                case .success(_):
                    CometChat.setSource(resource: "ui-kit", platform: "ios", language: "swift")
                case .failure(let error):
                    print( "Initialization Error:  \(error.localizedDescription)")
                    print( "Initialization Error Description:  \(error.localizedDescription)")
                }
            })
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        CometChat.configureServices(.willResignActive)
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        CometChat.configureServices(.didEnterBackground)
    }
    
    
    func applicationWillTerminate(_ application: UIApplication) {
        let authToken = ""
  
    }
}

