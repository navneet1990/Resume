//
//  TestingEnvironmentProtocol.swift
//  Resume
//
//  Created by Navneet Singh on 24/08/19.
//  Copyright © 2019 Navneet(navneet.aug1990@gmail.com,). All rights reserved.
//

import Foundation

/* Protocol for validating testing environment
  * Check if UI test case running
  * Check if both UI and Unit test running
  * Return local store mock taka
 **/
protocol TestingEnvironment {
  
  func isUITestCaseRunning() -> Bool
  func getMockData() -> Data?
  func isTestCaseRunning()-> Bool
}

extension TestingEnvironment{
  func isTestCaseRunning() -> Bool {
    return isUITestCaseRunning() || NSClassFromString("XCTest") != nil
  }
  func isUITestCaseRunning() -> Bool {
    return  ProcessInfo.processInfo.arguments.contains("isUITesting")
  }
  func getMockData() -> Data?{
    guard ProcessInfo.processInfo.environment["noData"] == "true" else{
      return Constants.Mock.data
    }
    return nil
  }
}

extension ResumeViewModal: TestingEnvironment{}
extension NetworkManager: TestingEnvironment{}
