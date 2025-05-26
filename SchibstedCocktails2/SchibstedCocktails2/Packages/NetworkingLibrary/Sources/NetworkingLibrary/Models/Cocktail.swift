//
//  Cocktail.swift
//  NetworkingLibrary
//
//  Created by Uladzislau Makei on 25.05.25.
//


import Foundation

public struct Cocktail: Decodable, Sendable, Equatable {
    public let name: String
    public let imageUrl: String

    public init(name: String, imageUrl: String) {
        self.name = name
        self.imageUrl = imageUrl
    }
}
