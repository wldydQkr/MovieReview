//
//  MockUserDefaultsManager.swift
//  MovieTests
//
//  Created by 박지용 on 2022/07/30.
//

import Foundation
@testable import Movie

final class MockUserDefaultsManager: USerDefaultsManagerProtocol {
    var isCalledGetMovies = false
    var isCalledAddMovie = false
    var isCalledRemoveMovie = false
    
    func getMovies() -> [Movie] {
        isCalledGetMovies = true
        return []
    }
    
    func addMovie(_ newValue: Movie) {
        isCalledAddMovie = true
    }
    
    func removeMovie(_ value: Movie) {
        isCalledRemoveMovie = true
    }
}
