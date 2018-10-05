//
//  CharacterMappingEntityTests.swift
//  CharacterMappingEntityTests
//
//  Created by Mario Plaza on 5/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import XCTest
@testable import WallaMarvelAPI

class CharacterMappingEntityTests: XCTestCase {
    
    override func setUp() {
        //    let JSONMockup:[String:Any] = ["id":123,
        //                                   "name":"Iron Man",
        //                                   "description":"A description",
        //                                   "modified":"Not a date",
        //                                   "thumbnail":"Not a thumbnail",
        //                                   "comics":"Not a comic data"]
    }
    
    override func tearDown() {
        
    }
    
    func testThatCharacterMappingEntityNotCreatedIfNoIDFound() {
        let JSONMockup:[String:Any] = ["name":"Iron Man",
                                       "description":"A description"]
        XCTAssertThrowsError(try CharacterMappingEntity(from: JSONMockup), "Character mapping entity created with no ID from JSON", { _ in })
    }
    
    func testThatCharacterMappingEntityNotCreatedIfNoNameFound() {
        let JSONMockup:[String:Any] = ["id":"123",
                                       "description":"A description"]
        XCTAssertThrowsError(try CharacterMappingEntity(from: JSONMockup), "Character mapping entity created with no name from JSON", { _ in })
    }
    
    func testThatCharacterMappingEntityGetsCreatedOnValidJSON(){
        let JSONMockup:[String:Any] = ["id":"123",
                                       "name":"Iron man"]
        XCTAssertNoThrow(try CharacterMappingEntity(from: JSONMockup), "Character mapping entity didnt get created on valid JSON")
    }
    
    func testThatCharacterMappingEntityGetsCreatedOnValidJSONWithDifferentTypes(){
        let JSONMockup:[String:Any] = ["id":123,
                                       "name":"Iron man"]
        XCTAssertNoThrow(try CharacterMappingEntity(from: JSONMockup), "Character mapping entity didnt get created on valid JSON")
    }
    
    func testThatCharacterMappingEntityGetsCreatedWhenModifiedDateIsCorrect(){
        let JSONMockup:[String:Any] = ["id":123,
                                       "name":"Iron man",
                                       "modified":"2018-10-05T16:18:29+00:00"]
        XCTAssertNoThrow(try CharacterMappingEntity(from: JSONMockup), "Character mapping entity didnt get created on valid modified date")
    }
    
    func testThatCharacterMappingEntityNotCreatedWhenModifiedDateIsCorrupted(){
        let JSONMockup:[String:Any] = ["id":123,
                                       "name":"Iron man",
                                       "modified":72]
        
        // Found that if we pass a malformed date string the SwiftDate library (that CharacterMappingEntity uses) crashes
        // Reported on: https://github.com/malcommac/SwiftDate/issues/603
//        XCTAssertThrowsError(try CharacterMappingEntity(from: JSONMockup), "Character mapping entity didnt get created on valid modified date")
    }
    
}
