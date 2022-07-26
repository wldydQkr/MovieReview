//
//  MovieDetailPresenter.swift
//  Movie
//
//  Created by 박지용 on 2022/07/20.
//

import Foundation

protocol MovieDetailProtocol: AnyObject {
    func setViews(with movie: Movie)
    func setRightBarButton(with isLiked: Bool)
}

final class MovieDetailPresenter {
    private weak var viewController: MovieDetailProtocol?
    
    private let userDefaultsManager: USerDefaultsManagerProtocol
    
    private var movie: Movie
    
    init(viewController: MovieDetailProtocol,
         movie: Movie,
         userDefaultsManager: USerDefaultsManagerProtocol = UserDefaultsManager()
    ) {
        self.viewController = viewController
        self.movie = movie
        self.userDefaultsManager = userDefaultsManager
    }
    
    func viewDidLoad() {
        viewController?.setViews(with: movie)
        viewController?.setRightBarButton(with: movie.isLiked)
    }
    
    func didTapRightBarButtonItem() {
        // OK -> movie.isLiked = false ->
        // userDefaults 에서 삭제
        // star.fill 울 star

        movie.isLiked.toggle()
        
        if movie.isLiked {
            userDefaultsManager.addMovie(movie)
        } else {
            userDefaultsManager.removieMovie(movie)
        }
        viewController?.setRightBarButton(with: movie.isLiked)
    }
}
