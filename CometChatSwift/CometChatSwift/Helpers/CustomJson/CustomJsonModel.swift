//
//  CustomJsonModel.swift
//  CometChatSwift
//
//  Created by admin on 11/08/22.
//  Copyright © 2022 MacMini-03. All rights reserved.
//

import Foundation

// MARK: - CustomJSONModel
struct CustomJSONModel: Codable {
    let chat, message, users,groups,shared : [[ModuleComponentModel]]
}

// MARK: - ModuleComponentModel
struct ModuleComponentModel: Codable {
    let heading: String
    let description: String
    let avatar : String

    enum CodingKeys: String, CodingKey {
        case heading
        case description
        case avatar
    }
}





