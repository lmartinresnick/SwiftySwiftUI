//
//  ShareManagerTests.swift
//  
//
//  Created by Luke Martin-Resnick on 5/17/22.
//

@testable import SwiftySwiftUI
import XCTest


class ShareManagerTests: XCTestCase {
    
    func test_doesNotCallShareMethod() {
        let sut = makeSUT()
        
        XCTAssertEqual(sut.shareSheetDidPresent, false)
        XCTAssertEqual(sut.shareToActivityVCCallCount, 0)
    }
    
    func test_callsShareMethod_noItems() {
        let sut = makeSUT()
        sut.shareToActivityVC(image: nil, text: nil, url: nil)
        
        XCTAssertEqual(sut.shareSheetDidPresent, false)
        XCTAssertEqual(sut.shareToActivityVCCallCount, 1)
    }
    
    func test_callsShareMethod_withItems() {
        let sut = makeSUT()
        let someImage = UIImage()
        let someText = "some text"
        
        sut.shareToActivityVC(image: someImage, text: someText, url: nil)
        
        XCTAssertEqual(sut.shareSheetDidPresent, true)
        XCTAssertEqual(sut.shareToActivityVCCallCount, 1)
    }
    
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> ShareManagerSpy {
        let sut = ShareManagerSpy()
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
    
    private class ShareManagerSpy: ShareManager {
        private(set) var shareSheetDidPresent: Bool = false
        private(set) var shareToActivityVCCallCount: Int = 0
        
        override func shareToActivityVC(image: UIImage? = nil, text: String? = nil, url: URL? = nil) {
            shareToActivityVCCallCount += 1
            var items: [Any] = []
            
            items.appendIfNotNil(image)
            items.appendIfNotNil(text)
            items.appendIfNotNil(url)
            
            shareSheetDidPresent = !items.isEmpty
        }
    }
}

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
}
