//
//  ViewController.swift
//  Movie
//
//  Created by 박지용 on 2022/07/05.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        MovieSearchMangaer().request(from: "Thor") { movies in
            print(movies)
        }
    }
}
