//
//  ViewController.swift
//  Movie
//
//  Created by 박지용 on 2022/07/05.
//

import UIKit

final class MovieListViewController: UIViewController {
    private lazy var presenter = MovieListPrenseter(viewController: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
}

extension MovieListViewController: MovieListProtocol {
    func setupNavigationBar() {
        navigationItem.title = "영화 평점"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
}
