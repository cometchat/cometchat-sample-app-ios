//
//  ApiCall.swift
//  CometChatSwift
//
//  Created by nabhodipta on 17/06/24.
//  Copyright © 2024 MacMini-03. All rights reserved.
//

import Foundation

extension URLSession {
  func fetchData<T: Decodable>(for url: URL, completion: @escaping (Result<T, Error>) -> Void) {
    self.dataTask(with: url) { (data, response, error) in
      if let error = error {
        completion(.failure(error))
      }
        

      if let data = data {
        do {
            let object = try JSONDecoder().decode(T.self, from: data)
          completion(.success(object))
        } catch let decoderError {
          completion(.failure(decoderError))
        }
      }
    }.resume()
  }
}
