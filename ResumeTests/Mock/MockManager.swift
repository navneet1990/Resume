//
//  MockManager.swift
//  ResumeTests
//
//  Created by Navneet Singh on 22/08/19.
//  Copyright © 2019 Navneet(navneet.aug1990@gmail.com,). All rights reserved.
//

import UIKit
@testable import Resume
 class MockNetworkSession: NetworkSession {
  var data: Data?
  var error: Error?
  
  func loadData(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
    completionHandler(data,error)
  }
}


