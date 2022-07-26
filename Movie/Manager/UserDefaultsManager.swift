//
//  UserDefaultsManager.swift
//  Movie
//
//  Created by 박지용 on 2022/07/26.
//

import Foundation

protocol USerDefaultsManagerProtocol {
    func getMovies() -> [Movie]
    func addMovie(_ newValue: Movie)
    func removieMovie(_ value: Movie)
}

struct UserDefaultsManager: USerDefaultsManagerProtocol {
    enum Key: String {
        case movie
    }
    
    func getMovies() -> [Movie] {
        guard let data = UserDefaults.standard.data(forKey: Key.movie.rawValue) else { return [] }
        
        return (try? PropertyListDecoder().decode([Movie].self, from: data)) ?? []
    }
    
    func addMovie(_ newValue: Movie) {
        var currentMovies: [Movie] = getMovies()
        currentMovies.insert(newValue, at: 0)
        
        // 새로 저장하기
        saveMovie(currentMovies)
    }
    
    func removieMovie(_ value: Movie) {
        let currentMovies: [Movie] = getMovies()
        let newValue = currentMovies.filter { $0.title != value.title }
        
        saveMovie(newValue)
    }
    
    private func saveMovie(_ newValue: [Movie]) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: Key.movie.rawValue)
    }
}
