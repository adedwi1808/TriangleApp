//
//  TriangleAppTests.swift
//  TriangleAppTests
//
//  Created by Gilang Ramadhan on 11/10/20.
//
import Foundation
import XCTest

@testable import TriangleApp

class TriangleAppTests: XCTestCase {

    func testInvalidInputDetectTriangle() {
        XCTAssertThrowsError(try detectTriangle(-1, -2, -3)) { error in
            XCTAssertEqual(error as? TriangleError, TriangleError.invalidInput)
        }
    }

    func testDetectEquilateralTriangle() {
        XCTAssertEqual(try detectTriangle(2, 2, 2), "Segitiga Sama Sisi")
    }

    func testDetectIsoscelesTriangle() {
        XCTAssertEqual(try detectTriangle(8, 8, 10), "Segitiga Sama Kaki")
        XCTAssertEqual(try detectTriangle(8, 10, 8), "Segitiga Sama Kaki")
        XCTAssertEqual(try detectTriangle(8, 10, 10), "Segitiga Sama Kaki")
        XCTAssertEqual(try detectTriangle(10, 8, 10), "Segitiga Sama Kaki")
    }

    func testDetectRandomTriangle() {
        XCTAssertEqual(try detectTriangle(3, 4, 5), "Segitiga Sembarang")
    }

    func testInequalityTriangle() {
        XCTAssertThrowsError(try detectTriangle(4, 1, 2)) { error in
            XCTAssertEqual(
                error as? TriangleError,
                TriangleError.inequalityInput
            )
        }
        XCTAssertThrowsError(try detectTriangle(5, 1, 3)) { error in
            XCTAssertEqual(
                error as? TriangleError,
                TriangleError.inequalityInput
            )
        }
    }

    func detectTriangle(
        _ sideA: Int,
        _ sideB: Int,
        _ sideC: Int
    ) throws -> String {

        let sides = [sideA, sideB, sideC].sorted()

        // 1. Invalid input (<= 0)
        for side in sides where side <= 0 {
            throw TriangleError.invalidInput
        }

        // 2. Triangle inequality rule
        if sides[0] + sides[1] <= sides[2] {
            throw TriangleError.inequalityInput
        }

        // 3. Triangle type
        if sides[0] == sides[1] && sides[1] == sides[2] {
            return "Segitiga Sama Sisi"
        }

        if sides[0] == sides[1] || sides[1] == sides[2] {
            return "Segitiga Sama Kaki"
        }

        return "Segitiga Sembarang"
    }

}

enum TriangleError: Error {
    case invalidInput
    case inequalityInput
}
