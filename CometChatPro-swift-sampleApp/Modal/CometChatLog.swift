//
//  CometChatLog.swift
//  CometChatPro-swift-sampleApp
//
//  Created by Admin1 on 28/03/19.
//  Copyright © 2019 Admin1. All rights reserved.
//

import Foundation

class CometChatLog{
    
    static func print(items: Any..., separator: String = " ", terminator: String = "\n"){
        
        if isDebug {
            
            var idx = items.startIndex;
            let endIdx = items.endIndex;
            
            repeat {
                
                Swift.print(items[idx], separator: separator, terminator: idx == (endIdx - 1) ? terminator : separator);
                idx += 1;
            }
                while idx < endIdx;
        }
    }
    
    
    
    static var isDebug : Bool {
        
        if let plistPath = Bundle.main.path(forResource: "CometChat-info", ofType: "plist"), let debugValue = NSDictionary(contentsOfFile: plistPath)?.object(forKey: "CometChatLog") as? String, debugValue == "1111" {
            return true
        }
        else {
            return false
        }
    }
    
}
