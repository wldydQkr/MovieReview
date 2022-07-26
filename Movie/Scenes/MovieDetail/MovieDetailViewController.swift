//
//  MovieDetailViewController.swift
//  Movie
//
//  Created by 박지용 on 2022/07/20.
//

import UIKit
import SnapKit
import Kingfisher

final class MovieDetailViewController: UIViewController {
    
    private var presenter: MovieDetailPresenter!
    
    private lazy var rightBarButtonItem = UIBarButtonItem(
        image: UIImage(systemName: "star"),
        style: .plain,
        target: self,
        action: #selector(didTapRightBarButtonItem)
    )
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .secondarySystemBackground
        
        return imageView
    }()
    
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
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        let userRatingContentsStackView = MovieContentStackView(title: "평점", contents: movie.userRating)
        let actorContentsStackView = MovieContentStackView(title: "베우", contents: movie.actor)
        let directorContentsStackView = MovieContentStackView(title: "감독", contents: movie.director)
        let pubDateContentsStackView = MovieContentStackView(title: "제작년도", contents: movie.pubDate)
        
        let contentsStackView = UIStackView()
        contentsStackView.axis = .vertical
        contentsStackView.spacing = 8.0
        
        [
            userRatingContentsStackView,
            actorContentsStackView,
            directorContentsStackView,
            pubDateContentsStackView
        ].forEach { contentsStackView.addArrangedSubview($0) }
        
        [imageView, contentsStackView]
            .forEach { view.addSubview($0) }
        
        let inset: CGFloat = 16.0
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).inset(inset)
            $0.leading.equalToSuperview().inset(inset)
            $0.trailing.equalToSuperview().inset(inset)
            $0.height.equalTo(imageView.snp.width)
        }
        
        contentsStackView.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.leading)
            $0.trailing.equalTo(imageView.snp.trailing)
            $0.top.equalTo(imageView.snp.bottom).offset(inset)
        }
        
        if let imageURL = movie.imageURL {
            imageView.kf.setImage(with: movie.imageURL)
        }
    }
    
    func setRightBarButton(with isLiked: Bool) {
        let imageName = isLiked ? "star.fill" : "star"
        rightBarButtonItem.image = UIImage(systemName: imageName)
    }
}

private extension MovieDetailViewController {
    @objc func didTapRightBarButtonItem() {
        presenter.didTapRightBarButtonItem()
    }
}
