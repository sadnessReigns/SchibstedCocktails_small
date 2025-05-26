//
//  SchibstedCocktails2Tests.swift
//  SchibstedCocktails2Tests
//
//  Created by Uladzislau Makei on 25.05.25.
//

import XCTest
import NetworkingLibrary
import NetworkingLibraryMocks

@testable import SchibstedCocktails2

final class SchibstedCocktails2Tests: XCTestCase {

    var sut: CocktailListViewModel!
    var service: CocktailServiceProtocol!
    var serviceMock: CocktailServiceMock {
        service as! CocktailServiceMock
    }

    override func setUp() {
        service = CocktailServiceMock()
        sut = .init(service: service)
    }

    override func tearDown() async throws {
        sut = nil
        service = nil
    }

    func test_loadData_nonEmpty() async throws {
        let expectedResult: [Cocktail] = [.init(name: "Name1", imageUrl: "url1")]
        serviceMock.expectedResult = expectedResult

        let expectation = XCTestExpectation(description: "loadData")

        await sut.loadData {
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 5)

        XCTAssertEqual(expectedResult, sut.cocktails)
    }

    func test_loadData_empty() async throws {
        let expectedResult: [Cocktail] = []
        serviceMock.expectedResult = expectedResult

        let expectation = XCTestExpectation(description: "loadData")

        await sut.loadData {
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 5)

        XCTAssertEqual(expectedResult, sut.cocktails)
    }

    func test_loadData_requestFailed() async throws {
        let error = CocktailServiceError.requestFailed
        serviceMock.throwError = error

        let expectation = XCTestExpectation(description: "loadData")

        await sut.loadData {
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 5)

        XCTAssertEqual(error.localizedDescription, sut.error?.localizedDescription)
    }
}
