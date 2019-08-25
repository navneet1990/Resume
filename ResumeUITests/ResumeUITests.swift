//
//  ResumeUITests.swift
//  ResumeUITests
//
//  Created by Navneet Singh on 22/08/19.
//  Copyright © 2019 Navneet(navneet.aug1990@gmail.com,). All rights reserved.
//

import XCTest

class ResumeUITests: XCTestCase {
  
  var app: XCUIApplication!
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    app = XCUIApplication()
    app.launchArguments.append("isUITesting")
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    app.terminate()
  }
  
  /**  Testing for  no data
   It will perform follwing tests
   * For Alert view opening to tapping buttin
   * Interaction with bar button
   * Validate message label text on screen
   */
  func testNoData() {
    app.launchEnvironment["noData"] = "true"
    app.launch()
    
    let alertBtn = app.alerts["Invalid Data"]
    XCTAssertTrue(alertBtn.waitForExistence(timeout: 1))
    alertBtn.buttons["Ok"].tap()
    let msgLbl =  app.staticTexts["ResumeViewController.messageLabel"]
    XCTAssertEqual(msgLbl.label, "Could not digest the fetched data")
    
    // Check the alert on tapping refresh button
    var didShowDialog = false
    addUIInterruptionMonitor(withDescription: "Invalid Data") { (alert) -> Bool in
      alert.buttons.element(boundBy: 0).tap()
      didShowDialog = true
      return true
    }
    
    // Press referesh bar button again
    expectation(for: NSPredicate() {(_,_) in
      let refreshBtn =   self.app.navigationBars["Resume"].buttons["refreshBarButton"]
      XCTAssertTrue(refreshBtn.exists)
      refreshBtn.tap()
      return didShowDialog
    }, evaluatedWith: NSNull(), handler: nil)
    
    waitForExpectations(timeout: 10) { (error: Error?) -> Void in
      if let error = error{
        print("Error: \(error.localizedDescription)")
      }
      self.app.terminate()
    }
  }
  
  /** Test Resume based upon mock data
   * Test Table View scrolling from top to end cell
   * Validate last row on reaching botton
   */
  func testResumeTable()  {
    app.launch()
    
    let tableView = app.tables["ResumeViewController.tableView"]
    XCTAssertTrue(tableView.exists)
    let profileCell = tableView.cells.staticTexts["ProfileCell.titleLabel"]
    XCTAssertTrue(profileCell.exists)
    XCTAssertEqual(profileCell.label, "UI Testing")
    
    
    // Check the last cell
    guard let lastCell = tableView.cells.allElementsBoundByIndex.last else { return }
    
    XCTAssertTrue(lastCell.exists)
    
    /// Scroll Up table view
    //Add in a count, so that the loop can escape if it's scrolled too many times
    let MAX_SCROLLS = tableView.cells.count
    var count = 0
    while lastCell.isHittable == false && count < MAX_SCROLLS {
      tableView.swipeUp()
      count += 1
    }
    //If there is only one label within the cell
    let textInLastCell = lastCell.descendants(matching: .staticText).firstMatch
    XCTAssertTrue(textInLastCell.label == "French" && textInLastCell.isHittable)
  }
  
}

private extension XCUIApplication {
  var isDisplayingResume: Bool {
    return otherElements["ResumeViewController"].exists
  }
}
