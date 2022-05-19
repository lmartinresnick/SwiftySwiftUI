//
//  DoubleTests.swift
//  
//
//  Created by Luke Martin-Resnick on 5/18/22.
//

@testable import SwiftySwiftUI
import XCTest

class DoubleTests: XCTestCase {

    func test_formatCurrency() {
        let someDouble = 1.2333333333
        
        XCTAssertEqual(someDouble.formatCurrency(), "$1.23")
    }
}
