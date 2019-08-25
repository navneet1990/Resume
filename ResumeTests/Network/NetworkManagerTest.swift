//
//  NetworkManagerTest.swift
//  ResumeTests
//
//  Created by Navneet Singh on 23/08/19.
//  Copyright © 2019 Navneet(navneet.aug1990@gmail.com,). All rights reserved.
//

import XCTest
@testable import Resume
class NetworkManagerTest: XCTestCase {
  
  var networkManager: NetworkManager?
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    let session = MockNetworkSession()
    session.data = Constants.Mock.data
    networkManager = NetworkManager.init(session:session)
    
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    networkManager = nil
  }
  
  
  func testSuccessRespose(){
    // When we don't provide any data to Mock session
    let expectation = XCTestExpectation(description: "Expected success with mock data")
    
    /// Dummy  url string will be used, which is never used
    networkManager?.fetchDataFromServer(urlString: "www.mock.com"){ (response) in
      switch response {
      // Handle the failure
      case .failure(_):
        XCTFail("No error expected")
      // Handle success
      case .success(_):
        expectation.fulfill()
      }
    }
    wait(for: [expectation], timeout: 5)
    
  }
}
 
