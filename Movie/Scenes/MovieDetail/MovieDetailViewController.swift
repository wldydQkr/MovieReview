//
//  MovieDetailViewController.swift
//  Movie
//
//  Created by 박지용 on 2022/07/20.
//

import UIKit
import SnapKit

final class MovieDetailViewController: UIViewController {
    
    private var presenter: MovieDetailPresenter!
    
    init(movie: Movie) {
        super.init(nibName: nil, bundle: nil)
        
        presenter = MovieDetailPresenter(viewController: self, movie: movie)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
}

extension MovieDetailViewController: MovieDetailProtocol {
    func setViews(with movie: Movie) {
        view.backgroundColor = .systemBackground
        
        navigationItem.title = movie.title
    }
}
