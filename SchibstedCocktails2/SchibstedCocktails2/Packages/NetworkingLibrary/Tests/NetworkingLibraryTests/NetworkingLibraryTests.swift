import XCTest
import NetworkingLibraryMocks
@testable import NetworkingLibrary

final class NetworkingLibraryTests: XCTestCase {

    private var sut: CocktailServiceProtocol!
    private var sutMock: CocktailServiceMock {
        sut as! CocktailServiceMock
    }

    override func setUp() {
        sut = CocktailServiceMock()
    }

    func test_fetch_empty() async throws {
        sutMock.expectedResult = []

        let result = try await sut.fetchCocktails()

        XCTAssertTrue(result.isEmpty)
    }

    func test_fetch_nonEmpty() async throws {
        let expectedResult: [Cocktail] = [.init(name: "Name1", imageUrl: "ImgURL1")]
        sutMock.expectedResult = expectedResult

        let result = try await sut.fetchCocktails()

        XCTAssertEqual(result, expectedResult)
    }
}
