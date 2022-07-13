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
}

final class MovieListPrenseter: NSObject {
    // weak var를 사용하면 메모리 참조에서 안전하기 때문에 화면이 생성됚다가 사라지는게 빈번하면 memory leak에 위험이 있기 때문에 weak var나 unwned let을 사용하면 더 안전한 코드로 구성이 가능함
    private weak var viewController: MovieListProtocol?
    
    init(viewController: MovieListProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupSearchBar()
    }
}

extension MovieListPrenseter: UISearchBarDelegate {}
