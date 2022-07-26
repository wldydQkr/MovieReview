//
//  MovieListPresenter.swift
//  Movie
//
//  Created by 박지용 on 2022/07/12.
//

import UIKit

protocol MovieListProtocol: AnyObject {
    func setupNavigationBar()
    func setupSearchBar()
    func setupViews()
    func updateSearchTableView(isHidden: Bool)
    func pushToMovieViewController(with movie: Movie)
    func updateCollectionView()
}

final class MovieListPrenseter: NSObject {
    // weak var를 사용하면 메모리 참조에서 안전하기 때문에 화면이 생성됚다가 사라지는게 빈번하면 memory leak에 위험이 있기 때문에 weak var나 unwned let을 사용하면 더 안전한 코드로 구성이 가능함
    private weak var viewController: MovieListProtocol?
    
    private let userDefaultsManager: USerDefaultsManagerProtocol
    
    private let movieSearchManager: MovieSearchManagerProtocol
    
    private var likedMovie: [Movie] = []
    
    private var currentMovieSearchResult: [Movie] = []
    
    init(
        viewController: MovieListProtocol,
        userDefaultsManager: USerDefaultsManagerProtocol = UserDefaultsManager(),
        movieSearchManager: MovieSearchManagerProtocol = MovieSearchMangaer()
    ) {
        self.viewController = viewController
        self.userDefaultsManager = userDefaultsManager
        self.movieSearchManager = movieSearchManager
    }
    
    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupSearchBar()
        viewController?.setupViews()
    }
    
    func viewWillAppear() {
        likedMovie = userDefaultsManager.getMovies()
        viewController?.updateCollectionView()
    }
}

extension MovieListPrenseter: UISearchBarDelegate {}

extension MovieListPrenseter: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 16.0
        let width: CGFloat = (collectionView.frame.width - spacing * 3) / 2
        return CGSize(width: width, height: 210.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset: CGFloat = 16.0
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
}
extension MovieListPrenseter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return likedMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =
        collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieListCollectionViewCell.identifier,
            for: indexPath) as? MovieListCollectionViewCell
        
        let movie = likedMovie[indexPath.item]
        cell?.update(movie)
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = likedMovie[indexPath.item]
        viewController?.pushToMovieViewController(with: movie)
    }
}

// MARK: UISearchBarDelegate
extension MovieListPrenseter: UITableViewDelegate {
    // searchBar 활성화 될 때
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewController?.updateSearchTableView(isHidden: false)
    }
    
    // seachBar 비활성화 될 때
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // cancle 버튼을 누르면 검색값을 빈 배열로 초기화
        currentMovieSearchResult = []
        viewController?.updateSearchTableView(isHidden: true)
    }
    
    // searchBar에서 값이 들어오면 불려지는 메서드
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        movieSearchManager.request(from: searchText) { [weak self] movies in
            self?.currentMovieSearchResult = movies
            self?.viewController?.updateSearchTableView(isHidden: false)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = currentMovieSearchResult[indexPath.row]
        viewController?.pushToMovieViewController(with: movie)
    }
}

extension MovieListPrenseter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currentMovieSearchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = currentMovieSearchResult[indexPath.row].title
        
        return cell
    }
}
