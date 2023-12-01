//
//  LanguageManager_iOSTests.swift
//  LanguageManager-iOSTests
//
//  Created by abedalkareem omreyh on 05/02/2022.
//

@testable import LanguageManager_iOS
import XCTest

class LanguageManageriOSTests: XCTestCase {

  override func setUpWithError() throws {
    try super.setUpWithError()
  }

  override func tearDownWithError() throws {
    try super.tearDownWithError()
  }

  func testExample() throws {
    LanguageManager.shared.defaultLanguage = .deviceLanguage
    print("text".localiz())
  }

  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }

}
