//
//  JsonDecoding.swift
//  CometChatSwift
//
//  Created by admin on 17/08/22.
//  Copyright © 2022 MacMini-03. All rights reserved.
//

import Foundation
class JsonDecoding {
   static func decodeJsonIntoCodable<T: Codable>(jsonString: String) -> T?{
        let jsonData = Data(jsonString.utf8)
        let decoder = JSONDecoder()
        
        do {
            let data = try decoder.decode(T.self, from: jsonData)
            print(data)
            return data
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
