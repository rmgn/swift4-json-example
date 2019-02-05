//
//  SwiftTestUITests.swift
//  SwiftTestUITests
//
//  Created by Ranjith Karuvadiyil on 31/01/19.
//  Copyright © 2019 mistybits. All rights reserved.
//

import XCTest
import UIKit
@testable import SwiftTest

class SwiftTestUITests: XCTestCase {
    var viewController: ViewController!


    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        viewController = (storyboard.instantiateInitialViewController()  as! ViewController)
        UIApplication.shared.keyWindow!.rootViewController = viewController
        
        XCTAssertNotNil(viewController.view)

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testGetFirstRow() {
        let testcollectionView = viewController.collectionView!
        let indexPath0 = IndexPath(item: 0, section: 0)
        
        let cell0 = testcollectionView.cellForItem(at: indexPath0)
        
        _ = testcollectionView.indexPathsForVisibleItems
        XCTAssert(testcollectionView.indexPathsForVisibleItems.contains(indexPath0)) // PASSED
        
        XCTAssert(cell0 != nil)     // FAILED
    }
}
