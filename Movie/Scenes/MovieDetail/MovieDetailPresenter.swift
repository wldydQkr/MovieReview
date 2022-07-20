//
//  MovieDetailPresenter.swift
//  Movie
//
//  Created by 박지용 on 2022/07/20.
//

import Foundation

protocol MovieDetailProtocol: AnyObject {}

final class MovieDetailPresenter {
    private weak var viewController: MovieDetailProtocol?
    
    init(viewController: MovieDetailProtocol) {
        self.viewController = viewController
    }
}
