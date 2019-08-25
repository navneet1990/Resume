//
//  AlertTest.swift
//  ResumeTests
//
//  Created by Navneet Singh on 21/08/19.
//  Copyright © 2019 Navneet(navneet.aug1990@gmail.com,). All rights reserved.
//

import XCTest
@testable import Resume
class AlertTests: XCTestCase {

    func testAlert() {
      let expectAlertActionHandlerCall = expectation(description: "Alert action handler called")
      
      let alert = SingleButtonAlert(
        title: "",
        message: "",
        action: AlertAction(buttonTitle: "", handler: {
          expectAlertActionHandlerCall.fulfill()
        })
      )
      
      alert.action.handler!()
      
      waitForExpectations(timeout: 0.1, handler: nil)
    }
  
}

