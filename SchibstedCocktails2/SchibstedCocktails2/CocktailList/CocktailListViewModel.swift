//
//  CocktailListViewModel.swift
//  SchibstedCocktails2
//
//  Created by Uladzislau Makei on 25.05.25.
//

import NetworkingLibrary
import Combine

final class CocktailListViewModel {
    
    private let service: CocktailServiceProtocol
    private(set) var cocktails: [Cocktail] = []

    @Published private(set) var error: Error? = nil

    init(service: CocktailServiceProtocol) {
        self.service = service
    }

    func loadData(_ completion: @escaping () -> Void) async {
        do {
            cocktails = try await service.fetchCocktails()
            completion()
        } catch {
            self.error = error
            completion()
        }
    }

}
