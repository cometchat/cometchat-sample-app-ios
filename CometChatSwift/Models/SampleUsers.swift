//
//  SampleUsers.swift
//  CometChatSwift
//
//  Created by nabhodipta on 17/06/24.
//  Copyright © 2024 MacMini-03. All rights reserved.
//

import Foundation

struct SampleUsers: Decodable {
  let users: [SampleUser]
  
  enum CodingKeys: String, CodingKey {
    case users = "users"
  }
}
