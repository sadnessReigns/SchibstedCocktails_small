//
//  CocktailServiceError.swift
//  NetworkingLibrary
//
//  Created by Uladzislau Makei on 25.05.25.
//


public enum CocktailServiceError: Error {
    case invalidResponse, requestFailed, decodingError
}