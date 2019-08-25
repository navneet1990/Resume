//
//  DecodeData.swift
//  Resume
//
//  Created by Navneet Singh on 24/08/19.
//  Copyright © 2019 Navneet(navneet.aug1990@gmail.com,). All rights reserved.
//

import Foundation

protocol DecodeData {
  
 /// Decode the data to Resume Object
 ///
 /// - Parameters:
 ///   - data: Data to be decoded
 ///   - completion:  Response in form of Resume if successfull otherwise error
 static func decode(data: Data,
                    completion: @escaping (_ result: Result<Resume,ErrorResult>) -> Void)
}

extension  NetworkManager :DecodeData{
 static func decode(data: Data,
                    completion: @escaping (_ result: Result<Resume,ErrorResult>) -> Void){
    // Decode the JSON
    do {
      // Decode the JSON into codable type Resume.
      let decoder = JSONDecoder()
      let responseJson = try decoder.decode(Resume.self, from: data)
      completion(.success(data: responseJson))
    }
    catch{
      completion(.failure(.invalidDataFormat))
    }
  }
}

