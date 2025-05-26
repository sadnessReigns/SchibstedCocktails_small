//
//  CocktailServiceMock.swift
//  NetworkingLibrary
//
//  Created by Uladzislau Makei on 25.05.25.
//

import NetworkingLibrary

public final class CocktailServiceMock: CocktailServiceProtocol {
    public var expectedResult: [Cocktail] = []
    public var throwError: CocktailServiceError?

    public init() {}
    
    public func fetchCocktails() async throws -> [Cocktail] {
        guard let throwError else {
            return expectedResult
        }

        throw throwError
    }
}
