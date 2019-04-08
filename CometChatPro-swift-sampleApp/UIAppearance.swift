//
//  UIAppearance.swift
//  CometChatPro-swift-sampleApp
//
//  Created by Pushpsen Airekar on 25/12/18.
//  Copyright © 2018 Pushpsen Airekar. All rights reserved.
//

import Foundation

public enum Appearance{
    case AzureRadiance
    case MountainMeadow
    case PersianBlue
    case Custom
}

extension String {
    
    var getApperance:Appearance? {
        
        switch self{
        case "AzureRadiance":
            return Appearance.AzureRadiance
        case "MountainMeadow":
            return Appearance.MountainMeadow
        case "PersianBlue":
            return Appearance.PersianBlue
        case "Custom":
            return Appearance.Custom
        default:
            return Appearance.PersianBlue
        }
    }
}

internal var UIAppearanceFontDict:[String:Any]? {
    if let path = Bundle.main.path(forResource: "CometChat-info", ofType: "plist") {
        if let dict = NSDictionary(contentsOfFile: path) as? [String:Any] {
            if let UIAppearanceFontDict  =  dict["UIAppearanceFont"] as? [String:Any] {
                return UIAppearanceFontDict
            }
        }
    }
    return nil;
}

internal var UIAppearanceColorDict:[String:Any]? {
    if let path = Bundle.main.path(forResource: "CometChat-info", ofType: "plist") {
        if let dict = NSDictionary(contentsOfFile: path) as? [String:Any] {
            if let UIAppearanceColorDict  =  dict["UIAppearanceColor"] as? [String:Any] {
                return UIAppearanceColorDict
            }
        }
    }
    return nil;
}

internal var UIAppearanceSizeDict:[String:Any]? {
    if let path = Bundle.main.path(forResource: "CometChat-info", ofType: "plist") {
        if let dict = NSDictionary(contentsOfFile: path) as? [String:Any] {
            if let UIAppearanceSizeDict  =  dict["UIAppearanceSize"] as? [String:Any] {
                return UIAppearanceSizeDict
            }
        }
    }
    return nil;
}

internal var AuthenticationDict:[String:Any]? {
    if let path = Bundle.main.path(forResource: "CometChat-info", ofType: "plist") {
        if let dict = NSDictionary(contentsOfFile: path) as? [String:Any] {
            if let AuthenticationDict  =  dict["Authentication"] as? [String:Any] {
                return AuthenticationDict
            }
        }
    }
    return nil;
}

var  AppAppearance:Appearance {
    
    let RootDictionary = NSDictionary.init(contentsOfFile: Bundle.main.path(forResource: "CometChat-info", ofType: "plist")!)
    if let UIAppearance = RootDictionary?.object(forKey: "UIApperance") as? String {
        
        return UIAppearance.getApperance ?? .PersianBlue
    }
    return .PersianBlue
}

enum fontTypes:String{
    case AzureRadianceRegular = "AvenirNext-Medium"
    case AzureRadianceBold = "AvenirNext-Bold"
    case AzureRadianceItalic = "AvenirNext-MediumItalic"
    case PersianBlueRegular = "ProductSans-Regular"
    case PersianBlueBold = "ProductSans-Bold"
    case PersianBlueItalic = "ProductSans-Italic"
    case MountainMeadowRegular = "HelveticaNeue-Medium"
    case MountainMeadowBold = "HelveticaNeue-Bold"
    case MountainMeadowItalic = "HelveticaNeue-MediumItalic"
    case CustomRegular = "g"
    case CustomBold = "df"
    case CustomItalic = "dfg"
}

public enum SystemFont{
    case regular
    case bold
    case italic
    
    var value:String {
        
        switch self {
            
        case .regular:
            switch AppAppearance{
            case .AzureRadiance:
                return fontTypes.AzureRadianceRegular.rawValue
            case .MountainMeadow:
                return fontTypes.MountainMeadowRegular.rawValue
            case .PersianBlue:
                return fontTypes.PersianBlueRegular.rawValue
            case .Custom:
                return UIAppearanceFontDict?["regular"] as! String  ?? "HelveticaNeue-Medium"
            }
        case .bold:
            
            switch AppAppearance{
                
            case .AzureRadiance:
                return fontTypes.AzureRadianceBold.rawValue
            case .MountainMeadow:
                return fontTypes.MountainMeadowBold.rawValue
            case .PersianBlue:
                return fontTypes.PersianBlueBold.rawValue
            case .Custom:
                return UIAppearanceFontDict?["bold"] as! String ?? "HelveticaNeue-Bold"
            }
            
        case .italic:
            
            switch AppAppearance{
                
            case .AzureRadiance:
                return fontTypes.AzureRadianceItalic.rawValue
            case .MountainMeadow:
                return fontTypes.MountainMeadowItalic.rawValue
            case .PersianBlue:
                return fontTypes.PersianBlueItalic.rawValue
            case .Custom:
                return UIAppearanceFontDict?["italic"] as! String ?? "HelveticaNeue-MediumItalic"
            }
        }
    }
}



class UIAppearanceFont {
    
    static var regular:String{
        
        return SystemFont.regular.value
    }
    
    static var bold:String{
        
        return SystemFont.bold.value
    }
    
    static var italic:String{
        
        return SystemFont.italic.value
    }
    
}


class UIAppearanceSize{
    
    static var CORNER_RADIUS:Double {
        
        switch AppAppearance{
            
        case .AzureRadiance:
            return 12.0
        case .MountainMeadow:
            return 0.0
        case .PersianBlue:
            return 20.0
        case .Custom:
            return UIAppearanceSizeDict?["CORNER_RADIUS"] as! Double ?? 0.0
        }
    }
    
    static var Padding:Double {
        
        switch AppAppearance{
            
        case .AzureRadiance:
            return 0.0
        case .MountainMeadow:
            return 0.0
        case .PersianBlue:
            return 10.0
        case .Custom:
            return UIAppearanceSizeDict?["Padding"] as! Double ?? 0.0
        }
    }
    
}

class UIAppearanceColor{
    
    static let NAVIGATION_BAR_COLOR:String = {
        
        switch AppAppearance{
            
        case .AzureRadiance:
            return "FFFFFF"
        case .MountainMeadow:
            return "FFFFFF"
        case .PersianBlue:
            return "2636BE"
        case .Custom:
            return UIAppearanceColorDict?["NAVIGATION_BAR_COLOR"] as! String ?? "FFFFFF"
        }
    }()
    
    static let NAVIGATION_BAR_TITLE_COLOR:String = {
        
        switch AppAppearance{
            
        case .AzureRadiance:
            return "000000"
        case .MountainMeadow:
            return "000000"
        case .PersianBlue:
            return "FFFFFF"
        case .Custom:
            return UIAppearanceColorDict?["NAVIGATION_BAR_TITLE_COLOR"] as! String ?? "FFFFFF"
        }
    }()
    
    static let NAVIGATION_BAR_BUTTON_TINT_COLOR:String = {
        
        switch AppAppearance{
            
        case .AzureRadiance:
            return "0084FF"
        case .MountainMeadow:
            return "0084FF"
        case .PersianBlue:
            return "FFFFFF"
        case .Custom:
            return UIAppearanceColorDict?["NAVIGATION_BAR_BUTTON_TINT_COLOR"] as! String ?? "FFFFFF"
        }
    }()
    
    static let BACKGROUND_COLOR:String = {
        
        switch AppAppearance{
            
        case .AzureRadiance:
            return "D9DBDD"
        case .MountainMeadow:
            return "25D366"
        case .PersianBlue:
            return "2636BE"
        case .Custom:
            return UIAppearanceColorDict?["BACKGROUND_COLOR"] as! String ?? "FFFFFF"
        }
    }()
    
    static let LOGIN_BUTTON_TINT_COLOR:String = {
        
        switch AppAppearance{
            
        case .AzureRadiance:
            return "0084FF"
        case .MountainMeadow:
            return "25D366"
        case .PersianBlue:
            return "2636BE"
        case .Custom:
            return UIAppearanceColorDict?["LOGIN_BUTTON_TINT_COLOR"] as! String ?? "FFFFFF"
        }
    }()
    
    
    static let LOGO_TINT_COLOR:String = {
        
        switch AppAppearance{
            
        case .AzureRadiance:
            return "000000"
        case .MountainMeadow:
            return "FFFFFF"
        case .PersianBlue:
            return "FFFFFF"
        case .Custom:
            return UIAppearanceColorDict?["LOGO_TINT_COLOR"] as! String ?? "FFFFFF"
        }
    }()
    
    static let RIGHT_BUBBLE_BACKGROUND_COLOR:String = {
        
        switch AppAppearance{
            
        case .AzureRadiance:
            return "0084FF"
        case .MountainMeadow:
            return "25D366"
        case .PersianBlue:
            return "2636BE"
        case .Custom:
            return UIAppearanceColorDict?["RIGHT_BUBBLE_BACKGROUND_COLOR"] as! String ?? "FFFFFF"
        }
    }()
    
    static let SEARCH_BAR_STYLE_LIGHT_CONTENT:Bool = {
        
        switch AppAppearance{
        case .AzureRadiance:
            return false
        case .MountainMeadow:
            return false
        case .PersianBlue:
            return true
        case .Custom:
            return ((UIAppearanceColorDict?["SEARCH_BAR_STYLE_LIGHT_CONTENT"]) != nil)
        }
    }()
    
}


