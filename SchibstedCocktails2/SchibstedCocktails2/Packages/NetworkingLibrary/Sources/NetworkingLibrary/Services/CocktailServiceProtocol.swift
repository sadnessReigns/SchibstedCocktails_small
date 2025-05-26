//
//  CocktailServiceProtocol.swift
//  NetworkingLibrary
//
//  Created by Uladzislau Makei on 25.05.25.
//

public protocol CocktailServiceProtocol {
    func fetchCocktails() async throws -> [Cocktail]
}
