//
//  ErrorResultTests.swift
//  ResumeTests
//
//  Created by Navneet Singh on 22/08/19.
//  Copyright © 2019 Navneet(navneet.aug1990@gmail.com,). All rights reserved.
//

import XCTest

@testable import Resume
class ErrorResultTests: XCTestCase {
  
  var sut: ErrorResult!
  
  func testNetworkConnectionSuccessfully(){
    sut = .networkUnavailable
    XCTAssertEqual(sut.description, "Check your network connection")
    XCTAssertEqual(sut.title, "Network")
  }
  
  func testInvalidUrlSuccessfully(){
    sut = .invalidUrl
    XCTAssertEqual(sut.description, "Could not create a URL")
    XCTAssertEqual(sut.title, "Invalid Url")
  }
  func testInvalidResponseSuccessfully() {
    sut = .invalidDataFormat
    XCTAssertEqual(sut.description, "Could not digest the fetched data")
    XCTAssertEqual(sut.title, "Invalid Data")
  }
}
