//
//  DecoderTests.swift
//  MauriUtilsTests
//
//  Created by Mauricio Chirino on 24/03/2019.
//  Copyright © 2019 Mauricio Chirino. All rights reserved.
//

import XCTest
@testable import MauriUtils

final class DecoderTests: XCTestCase {
    func testDecoding() {
        var userRawData: Data {
            return Data("""
                {
                    "name": "Mauricio Chirino",
                    "age": 29,
                    "birthday": 620319600
                }
            """.utf8)
        }
        let userDecoded: TestUserMock = try! JSONDecodable.map(input: userRawData)
        let temporalUser = TestUserMock()
        XCTAssert(userDecoded == temporalUser)
    }

    func testMissingKey() {
        var userRawData: Data {
            return Data("""
                {
                    "name": "Mauricio Chirino",
                    "age": 29,
                    "": 620319600
                }
            """.utf8)
        }
        do {
            let _: TestUserMock = try JSONDecodable.map(input: userRawData)
        } catch let error as FileDecodableError {
            switch error {
            case .missingKey(_):
                XCTAssert(true)
                return
            default:
                XCTAssert(false)
            }
        } catch { }
    }

    func testMissingValue() {
        var userRawData: Data {
            return Data("""
                {
                    "name": "Mauricio Chirino",
                    "age": 29,
                    "birthday": null
                }
            """.utf8)
        }
        do {
            let _: TestUserMock = try JSONDecodable.map(input: userRawData)
        } catch let error as FileDecodableError {
            switch error {
            case .missingValue(_):
                XCTAssert(true)
                return
            default:
                XCTAssert(false)
            }
        } catch { }
    }

    func testDataWrongFormat() {
        var userRawData: Data {
            return Data("""
                {
                    "name": "Mauricio Chirino",
                    "age": 29,
                    "birthday": "28/08/1989"
                }
            """.utf8)
        }
        do {
            let _: TestUserMock = try JSONDecodable.map(input: userRawData)
        } catch let error as FileDecodableError {
            switch error {
            case .wrongFormat(_):
                XCTAssert(true)
                return
            default:
                XCTAssert(false)
            }
        } catch { }
    }

    func testCorruptedData() {
        var userRawData: Data {
            return Data("""
                {
                    "name": "Mauricio Chirino",
                    "age": 29,
                    birthday: 28/08/1989
                }
            """.utf8)
        }
        do {
            let _: TestUserMock = try JSONDecodable.map(input: userRawData)
        } catch let error as FileDecodableError {
            switch error {
            case .dataCorrupted(_):
                XCTAssert(true)
                return
            default:
                XCTAssert(false)
            }
        } catch { }
    }

}