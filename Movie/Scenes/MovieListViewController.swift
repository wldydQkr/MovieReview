//
//  ViewController.swift
//  Movie
//
//  Created by 박지용 on 2022/07/05.
//

import UIKit

final class MovieListViewController: UIViewController {
    private lazy var presenter = MovieListPrenseter(viewController: self)
    
    private let searchController = UISearchController()
    
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
    
    func setupSearchBar() {
        // searchBar 활설 시 배경색 어둡게
        searchController.obscuresBackgroundDuringPresentation = false
        // searchBar의 자동완성을 사용하기 위해서는 delegate를 사용해야 한다.
        searchController.searchBar.delegate = presenter
        navigationItem.searchController = searchController
    }
    
}
