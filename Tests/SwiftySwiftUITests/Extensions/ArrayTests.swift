//
//  ArrayTests.swift
//  
//
//  Created by Luke Martin-Resnick on 5/18/22.
//

@testable import SwiftySwiftUI
import XCTest

class ArrayTests: XCTestCase {

    func test_appendIfNotNil_withNonNilElement() {
        let someString: String = "some string"
        someArray.appendIfNotNil(someString)
        
        XCTAssertFalse(someArray.isEmpty)
    }
    
    func test_appendIfNotNil_withNilElement() {
        let someInt: Int? = nil
        someArray.appendIfNotNil(someInt)
        
        XCTAssertTrue(someArray.isEmpty)
    }

    private lazy var someArray: [Any] = {
        []
    }()
}
