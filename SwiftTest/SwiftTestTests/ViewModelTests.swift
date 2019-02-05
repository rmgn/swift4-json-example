//
//  ViewModelTests.swift
//  SwiftTestTests
//
//  Created by Ranjith Karuvadiyil on 05/02/19.
//  Copyright © 2019 mistybits. All rights reserved.
//

import XCTest
@testable import SwiftTest

class ViewModelTests: XCTestCase {
    var viewModel : ViewModel!
    fileprivate var service : MockService!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.service = MockService()
        self.viewModel = ViewModel(viewDelegate: service as! someProtocol)

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.viewModel = nil
        self.service = nil
        super.tearDown()

    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
   
}

fileprivate class MockService : ViewModelTests {
    
    var swifter : Swifter?
    
     func getDaraFromUrl(completion: @escaping (_ swifter: Swifter?,_ error: Error?) -> Void) {
        
        if swifter != nil {
            completion(swifter, (Error?.self as! Error))
        }
    }
}
