//
//  ViewController.swift
//  Movie
//
//  Created by 박지용 on 2022/07/05.
//

import UIKit
import SnapKit

final class MovieListViewController: UIViewController {
    private lazy var presenter = MovieListPrenseter(viewController: self)
    
    private let searchController = UISearchController()
    
    private lazy var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = presenter
        collectionView.dataSource = presenter
        
        collectionView.register(
            MovieListCollectionViewCell.self,
            forCellWithReuseIdentifier: MovieListCollectionViewCell.identifier
        )
        
        return collectionView
    }()
    
    private lazy var searchResultTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = presenter
        tableView.dataSource = presenter
        
        return tableView
    }()
    
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
    
    func setupViews() {
        [collectionView, searchResultTableView]
            .forEach { view.addSubview($0)}
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        searchResultTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        searchResultTableView.isHidden = true
    }
    
    func updateSearchTableView(isHidden: Bool) {
        searchResultTableView.isHidden = isHidden
    }
}
