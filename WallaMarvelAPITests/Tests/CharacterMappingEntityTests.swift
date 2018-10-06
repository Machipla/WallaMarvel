//
//  CharacterMappingEntityTests.swift
//  CharacterMappingEntityTests
//
//  Created by Mario Plaza on 5/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import XCTest
import Nimble
@testable import WallaMarvelAPI

class CharacterMappingEntityTests: XCTestCase {
    
    var JSONMock = CharacterJSONMock()

    override func setUp() {
        super.setUp()
        JSONMock.clearUp()
    }
    
    func testThatCharacterCreatedOnValidJSON(){
        let JSON = JSONMock.creatingValid()
            .injecting(on: .description, value: .string("A description"))
            .injecting(on: .modified, value: .string("2016-09-28T12:15:21-0400"))
            .injecting(on: .thumbnail, value: .dictionary(["path":.string("http://i.annihil.us/u/prod/marvel/i/mg/3/50/526548a343e4b"),"extension":.string("jpg")]))
            .injecting(on: .comics, value: .dictionary(["items":.array([])])).JSON
        
        let characterCreation = { return try? CharacterMappingEntity(from: JSON).asEntity }
        expect(characterCreation).notTo(beNil())
        
        let character = characterCreation()
        expect{ character?.modified }.notTo(beNil())
        expect{ character?.thumbnail }.notTo(beNil())
        expect{ character?.comicsData }.notTo(beNil())
    }
    
    func testThatCharacterMappingEntityNotCreatedIfNoIDFound() {
        let JSON = JSONMock.injecting(on: .name, value: .string("Iron man")).injecting(on: .description, value: .string("A description")).JSON
        expect{ try CharacterMappingEntity(from: JSON) }.to(throwError())
    }
    
    func testThatCharacterMappingEntityNotCreatedIfNoNameFound() {
        let JSON = JSONMock.injecting(on: .ID, value: .string("123")).injecting(on: .description, value: .string("A description")).JSON
        expect{ try CharacterMappingEntity(from: JSON) }.to(throwError())
    }
    
    func testThatCharacterMappingEntityGetsCreatedOnValidJSON(){
        let JSON = JSONMock.creatingValid().JSON
        expect{ try CharacterMappingEntity(from: JSON) }.notTo(throwError())
    }
    
    func testThatCharacterMappingEntityGetsCreatedOnValidJSONWithDifferentTypes(){
        let JSON = JSONMock.injecting(on: .ID, value: .int(123)).injecting(on: .name, value: .string("Wolverine")).JSON
        expect{ try CharacterMappingEntity(from: JSON) }.notTo(throwError())
    }
    
    func testThatCharacterMappingEntityGetsCreatedWhenModifiedDateIsCorrect(){
        let JSON = JSONMock.injecting(on: .ID, value: .string("123"))
            .injecting(on: .name, value: .string("Wolverine"))
            .injecting(on: .modified, value: .string("2018-10-05T16:18:29+00:00")).JSON
        expect{ try CharacterMappingEntity(from: JSON) }.notTo(throwError())
    }
    
    func testThatCharacterMappingEntityNotCreatedWhenModifiedDateCorrupted(){
        let JSON = JSONMock.injecting(on: .ID, value: .int(123))
            .injecting(on: .name, value: .string("Iron man"))
            .injecting(on: .modified, value: .int(72)).JSON
        expect{ try CharacterMappingEntity(from: JSON) }.to(throwError())
    }
    
    func testThatCharacterMappingEntityNotCreatedWhenThumbnailCorrupted(){
        let JSON = JSONMock.creatingValid().injecting(on: .thumbnail, value: .dictionary(["Not a thumbnail":.string("But a smile :D")])).JSON
        expect{ try CharacterMappingEntity(from: JSON) }.to(throwError())
    }
}
