//
//  MergeTests.swift
//  GenericJSONTests
//
//  Created by Cameron McOnie on 2018/10/02.
//  Copyright © 2018 Tomáš Znamenáček. All rights reserved.
//

import XCTest
@testable import GenericJSON

class MergeTests: XCTestCase {
    
//    func testDifferingTypes() {
//        let A = JSON("a")
//        let B = JSON(1)
//        
//        do {
//            _ = try A.merged(with: B)
//        } catch let error as SwiftyJSONError {
//            XCTAssertEqual(error.errorCode, SwiftyJSONError.wrongType.rawValue)
//            XCTAssertEqual(type(of: error).errorDomain, SwiftyJSONError.errorDomain)
//            XCTAssertEqual(error.errorUserInfo as! [String: String], [NSLocalizedDescriptionKey: "Couldn't merge, because the JSONs differ in type on top level."])
//        } catch _ {}
//    }
    
    func testPrimitiveType() {
        let A = try! JSON("a")
        let B = try! JSON("b")
        XCTAssertEqual(try! A.merged(with: B), B)
    }
    
    func testMergeEqual() {
        let json = try! JSON(["a": "A"])
        XCTAssertEqual(try! json.merged(with: json), json)
    }
    
    func testMergeUnequalValues() {
        let A = try! JSON(["a": "A"])
        let B = try! JSON(["a": "B"])
        XCTAssertEqual(try! A.merged(with: B), B)
    }
    
    func testMergeUnequalKeysAndValues() {
        let A = try! JSON(["a": "A"])
        let B = try! JSON(["b": "B"])
        XCTAssertEqual(try! A.merged(with: B), try! JSON(["a": "A", "b": "B"]))
    }
    
    func testMergeFilledAndEmpty() {
        let A = try! JSON(["a": "A"])
        let B = try! JSON([:])
        XCTAssertEqual(try! A.merged(with: B), A)
    }
    
    func testMergeEmptyAndFilled() {
        let A = try! JSON([:])
        let B = try! JSON(["a": "A"])
        XCTAssertEqual(try! A.merged(with: B), B)
    }
    
    func testMergeArray() {
        let A = try! JSON(["a"])
        let B = try! JSON(["b"])
        
        let x = try! JSON(["a", "b"])
        
        XCTAssertEqual(try! A.merged(with: B), x)
    }
    
    func testMergeNestedJSONs() {
        let A = try! JSON([
            "nested": [
                "A": "a"
            ]
            ])
        
        let B = try! JSON([
            "nested": [
                "A": "b"
            ]
            ])
        
        XCTAssertEqual(try! A.merged(with: B), B)
    }
}
