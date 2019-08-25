//
//  NetworkProtocol.swift
//  PlasticChallenge
//
//  Created by Navneet Singh on 22/08/19.
//  Copyright © 2019 Navneet. All rights reserved.
//


// Network Protocol
protocol NetworkProtocol : class {
  // TypeAlias for custom content
  typealias ResumeResult = Result<Resume,ErrorResult>
  typealias ResumeCompletion = (_ result: ResumeResult) -> Void
  

  /// Method to fetch data server
  ///
  /// - Parameters:
  ///   - urlString: Url to interact with server
  ///   - completion: Response in form of Resume if successfull otherwise error
  func fetchDataFromServer(urlString: String,completion: @escaping ResumeCompletion)
}
