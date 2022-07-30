//
//  MovieListPresenterTests.swift
//  MovieTests
//
//  Created by 박지용 on 2022/07/30.
//

import XCTest

@testable import Movie

class MovieListPresenterTests: XCTestCase {
    var sut: MovieListPrenseter!
    
    var viewController: MockMovieListViewController
    var userDefaultsManager: MockUserDefaultsManager
    var movieSearchManager: MockMovieSearchManager
    
    override func setUp() {
        super.setUp()
        
        viewController = MockMovieListViewController()
        userDefaultsManager = MockUserDefaultsManager()
        movieSearchManager = MockMovieSearchManager()
        
        sut = MovieListPrenseter(viewController: viewController, userDefaultsManager: userDefaultsManager, movieSearchManager: movieSearchManager)
    }
    
    override func tearDown() {
        sut = nil
        
        viewController = nil
        userDefaultsManager = nil
        movieSearchManager = nil
    }
}
