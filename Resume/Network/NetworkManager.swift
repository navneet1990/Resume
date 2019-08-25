//
//  NetworkManager.swift
//  PlasticChallenge
//
//  Created by Navneet Singh on 21/08/19.
//  Copyright © 2019 Navneet(navneet.aug1990@gmail.com,). All rights reserved.
//

import Foundation

final class NetworkManager: NetworkProtocol {
  typealias ResumeResult = Result<Resume,ErrorResult>
  typealias ResumeCompletion = (_ result: ResumeResult) -> Void
  
  
  private let session: NetworkSession
  
  init(session: NetworkSession = URLSession.shared) {
    
    self.session = session
  }
  
  func fetchDataFromServer(urlString:String = Constants.Network.API,
                           completion: @escaping ResumeCompletion){
    
    // Validate for UI testing
    if isUITestCaseRunning(){
      guard let data = getMockData() else{
        completion(.failure(.invalidDataFormat))
        return
      }
      
      NetworkManager.decode(data: data, completion: completion)
      return
    }
    // Create a URL to load, and a URLSession to load it.
    guard let jsonURL = URL(string: urlString) else {
      completion(.failure(.invalidUrl))
      return
    }
    
    session.loadData(from: jsonURL) {[unowned self] data, error in
      
      // Alert the user if no data comes back.
      guard let data = data else {
        completion(.failure(.networkUnavailable))
        return
      }
      // If no test is running then, store in User defaults
      if !self.isTestCaseRunning() { UserDefaults.standard.resume = data}
      
      // Decode the JSON
      NetworkManager.decode(data: data, completion: completion)
    }
  }
}


