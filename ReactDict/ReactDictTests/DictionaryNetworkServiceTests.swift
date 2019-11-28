//
//  DictionaryNetworkServiceTests.swift
//  ReactDictTests
//
//  Created by Aliaksandr Baranouski on 11/10/2019.
//  Copyright © 2019 naschekrasche. All rights reserved.
//

import XCTest

@testable import ReactDict


class DictionaryNetworkServiceTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }


    func testWordType_conformsCodable_succeeded() {

        do {
            //here dataResponse received from a network request
            let json : [String : Encodable] = ["word" :"cz",
                                               "translate" : ["val1", "val2"],
                                               "exercises" : [1,2]]

            let jsonEncoder = JSONEncoder()
            jsonEncoder.outputFormatting = .prettyPrinted
            let jsonData = try! jsonEncoder.encode(json)

            let decoder = JSONDecoder()
            let model = try decoder.decode(Word.self,
                                           from: jsonData)

            let benchmark = Word(word: "cz",
                                 translate: ["val2", "val1"],
                                 exercises: [ Exercise.reversedTranslate, Exercise.directTranslate])
            XCTAssert(model == benchmark)
        } catch let parsingError {
            print("Parsing Error:", parsingError)
        }
    }
    
    
    func testDictionaryType_conformsCodable_succeeded() {
        
        do {
            let path = Bundle(for: type(of: self)).path(forResource: "cz-ru",
                                                        ofType: "json") ?? ""
            let url = URL(fileURLWithPath: path)
            let data = try Data.init(contentsOf: url)
            
            let decoder = JSONDecoder()
            let model = try decoder.decode(Dictionary.self,
                                           from: data)
            
            XCTAssert(model.count == 10)
        } catch let parsingError {
            print("Parsing Error:", parsingError)
            XCTAssert(false)
        }
    }
}


private extension Encodable {
    func encode(to container: inout SingleValueEncodingContainer) throws {
        try container.encode(self)
    }
}

extension JSONEncoder {
    private struct EncodableWrapper: Encodable {
        let wrapped: Encodable

        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try self.wrapped.encode(to: &container)
        }
    }

    func encode<Key: Encodable>(_ dictionary: [Key: Encodable]) throws -> Data {
        let wrappedDict = dictionary.mapValues(EncodableWrapper.init(wrapped:))
        return try self.encode(wrappedDict)
    }
}
