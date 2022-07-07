//
//  MovieSearchResponseModel.swift
//  Movie
//
//  Created by 박지용 on 2022/07/08.
//

import Foundation

struct MovieSearchResponseModel: Decodable {
    var items: [Movie] = []
}
