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
}

final class MovieListPrenseter: NSObject {
    // weak var를 사용하면 메모리 참조에서 안전하기 때문에 화면이 생성됚다가 사라지는게 빈번하면 memory leak에 위험이 있기 때문에 weak var나 unwned let을 사용하면 더 안전한 코드로 구성이 가능함
    private weak var viewController: MovieListProtocol?
    
    private var likedMovie: [Movie] = [
        Movie(title: "Topgun", imageURL: "", userRating: "10.0", actor: "123", director: "123", pubDate: "2022"),
        Movie(title: "Topgun", imageURL: "", userRating: "10.0", actor: "123", director: "123", pubDate: "2022"),
        Movie(title: "Topgun", imageURL: "", userRating: "10.0", actor: "123", director: "123", pubDate: "2022")
    ]
    
    init(viewController: MovieListProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupSearchBar()
        viewController?.setupViews()
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
}

// MARK: UISearchBarDelegate
extension MovieListPrenseter: UITableViewDelegate {
    // searchBar 활성화 될 때
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewController?.updateSearchTableView(isHidden: false)
    }
    
    // seachBar 비활성화 될 때
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewController?.updateSearchTableView(isHidden: true)
    }
}

extension MovieListPrenseter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath)"
        
        return cell
    }
    
    
}
