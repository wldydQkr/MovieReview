//
//  MovieDetailViewController.swift
//  Movie
//
//  Created by 박지용 on 2022/07/20.
//

import UIKit
import SnapKit

final class MovieDetailViewController: UIViewController {
    
    private lazy var presenter = MovieDetailPresenter(viewController: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
    }
}

extension MovieDetailViewController: MovieDetailProtocol {}
