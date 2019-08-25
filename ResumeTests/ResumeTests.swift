//
//  ResumeTests.swift
//  ResumeTests
//
//  Created by Navneet Singh on 21/08/19.
//  Copyright © 2019 Navneet(navneet.aug1990@gmail.com). All rights reserved.
//

import XCTest
@testable import Resume

class ResumeTests: XCTestCase {

  var vc: ResumeViewController!
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    let session = MockNetworkSession()
    session.data = Constants.Mock.data
    let  viewModel = ResumeViewModal.init(session)
    
    vc = ResumeViewController()
    vc.viewModel = viewModel
    vc.viewDidLoad()
    vc?.viewWillAppear(false)
    
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    vc = nil
  }
  
  func testTableSections() {
    // Initially empty
    
    XCTAssertEqual(vc.tableView.numberOfSections, 6)
    
    let summarySectionRows = vc.tableView.numberOfRows(inSection: vc.viewModel.resume.value?.countTableRows(forSection: 1) ?? 0)
    let expSectionRows = vc.tableView.numberOfRows(inSection: vc.viewModel.resume.value?.countTableRows(forSection: 2) ?? 0)
    
    XCTAssertEqual(summarySectionRows, 1)
    XCTAssertEqual(expSectionRows, 2)
    
  }
    
}

