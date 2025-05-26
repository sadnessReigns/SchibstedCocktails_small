//
//  CocktailService.swift
//  NetworkingLibrary
//
//  Created by Uladzislau Makei on 25.05.25.
//

import Foundation

public final class CocktailService: CocktailServiceProtocol {
    private let url = URL(string: "http://schibsted-nde-apps-recruitment-task.eu-central-1.elasticbeanstalk.com/cocktails")!

    public init() {}

    public func fetchCocktails() async throws -> [Cocktail] {
        try await Task.detached(priority: .userInitiated) {
            let url = URL(string: "http://schibsted-nde-apps-recruitment-task.eu-central-1.elasticbeanstalk.com/cocktails")!
            var request = URLRequest(url: url)
            let loginString = "schibsted:mojito"
            let loginData = loginString.data(using: .utf8)!
            let base64LoginString = loginData.base64EncodedString()
            request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
            request.timeoutInterval = 15

            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            return try JSONDecoder().decode([Cocktail].self, from: data)
        }.value
    }
}
