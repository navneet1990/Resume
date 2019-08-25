//
//  ResumeViewModel.swift
//  ResumeTests
//
//  Created by Navneet Singh on 22/08/19.
//  Copyright © 2019 Navneet(navneet.aug1990@gmail.com,). All rights reserved.
//

import XCTest
@testable import Resume
class ResumeViewModelTests: XCTestCase {
  
  var mockSession: MockNetworkSession!
  var viewModel: ResumeViewModal!
  
  override func setUp() {
    mockSession = MockNetworkSession()
    viewModel = ResumeViewModal.init(mockSession)
  }
  override func tearDown() {
    mockSession = nil
    viewModel = nil
  }
  
  
  func testResumeFailure(){
    let expectation = XCTestExpectation(description: "Activity indicator stopped animationg and label is emptyu")
    // expected completion to fail
    viewModel.showAlert.bind({ (alert) in
      expectation.fulfill()
    })
    
    // expected completion to fail
    viewModel.resume.bind({ (resume) in
      XCTFail("No data expected")
    })
    
    // Without mock data
    viewModel.fetchResume()
    
    // Wait for max 5 seconds for  response
    wait(for: [expectation], timeout: 5)
  }
  
  
  func testResumeSuccess() {
    
    let expectation = XCTestExpectation(description: "Correct Response Recieved and decoded to Resume object")
    let expectation1 = XCTestExpectation(description: "Activity indicator stopped animationg and label is emptyu")
    // Dependency injection using mock data
    
    mockSession.data = Constants.Mock.data
    XCTAssertNil(viewModel.resume.value, "So far we haven't fetch any data")
    
    
    // expected completion to fail
    viewModel.showAlert.bind({ (alert) in
      XCTFail("Alert will be shown when there is error")
    })
    
    // Activity indicator unbind
    viewModel.activityIndicatorDetails.bind { (details) in
      XCTAssertEqual(details.0,false)
      XCTAssertEqual(details.1, "")
      expectation1.fulfill()
    }
    
    // On Receving data
    viewModel.resume.bind { (resume) in
      guard let resume = resume else{
        XCTFail("Invalid data")
        return
      }
      XCTAssertEqual(resume.profile.name, "Mock Data")
      XCTAssertEqual(resume.profile.title, "UI Testing")
      XCTAssertEqual(resume.summary.count, 3)
      XCTAssertEqual(resume.education.first?.area, "Computer Science")
      
      expectation.fulfill()
    }
    viewModel.fetchResume()
    // Wait for max 5 seconds for server response
    wait(for: [expectation, expectation1], timeout: 5)
    
  }
}
