//
//  SampleUser.swift
//  CometChatSwift
//
//  Created by nabhodipta on 17/06/24.
//  Copyright © 2024 MacMini-03. All rights reserved.
//

import Foundation

struct SampleUser: Decodable {
  let uid: String
  let name: String
  let avatar: String
  
  enum CodingKeys: String, CodingKey {
    case uid = "uid"
    case name = "name"
      case avatar = "avatar"
  }
}
