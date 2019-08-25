//
//  UIFont+StylesTests.swift
//  ResumeTests
//
//  Created by Navneet Singh on 24/08/19.
//  Copyright © 2019 Navneet(navneet.aug1990@gmail.com,). All rights reserved.
//

import XCTest
@testable import Resume
class UIFont_StylesTests: XCTestCase {
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  func testFontStyles(){
    let headline = UIFont.preferredResumeFont(forTextStyle: .headline)
    let subheadline =  UIFont.preferredResumeFont(forTextStyle: .subheadline)
    let bodyStyle = UIFont.preferredResumeFont(forTextStyle: .body)
    let footerStyle = UIFont.preferredResumeFont(forTextStyle: .footnote)
    
    XCTAssertEqual(headline, UIFont(name: "HelveticaNeue-Bold", size: 20)!)
    XCTAssertEqual(subheadline, UIFont(name: "HelveticaNeue-Medium", size: 18)!)
    XCTAssertEqual(bodyStyle, UIFont(name: "HelveticaNeue", size: 15))
    XCTAssertEqual(footerStyle, UIFont(name: "HelveticaNeue-Light", size: 13)!)
  
  }
}
