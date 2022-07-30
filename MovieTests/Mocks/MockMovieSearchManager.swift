//
//  MockMovieSearchManager.swift
//  MovieTests
//
//  Created by 박지용 on 2022/07/30.
//

import Foundation
@testable import Movie

final class MockMovieSearchManager: MovieSearchManagerProtocol {
    var isCalledRequest = false
    var needToSuccessRequest = false
    
    func request(from keyword: String, completionHandler: @escaping ([Movie]) -> Void) {
        isCalledRequest = true
        
        if needToSuccessRequest {
            completionHandler([])
        }
    }
}
