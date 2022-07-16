//
//  MovieSearchManager.swift
//  Movie
//
//  Created by 박지용 on 2022/07/08.
//

import Alamofire
import Foundation

protocol MovieSearchManagerProtocol {
    func request(from keyword: String, completionHandler: @escaping([Movie]) -> Void)
}

struct MovieSearchMangaer: MovieSearchManagerProtocol {
    func request(from keyword: String, completionHandler: @escaping([Movie]) -> Void) {
        guard let url = URL(string: "https://openapi.naver.com/v1/search/movie.json") else { return }
        let parameters = MovieSaearchRequestModel(query: keyword)
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": "7loFCPegLR1d3CjSx3Vg",
            "X-Naver-Client-Secret": "0MPxqwjBWQ"
        ]
        AF.request(
            url,
            method: .get,
            parameters: parameters,
            headers: headers
        )
        .responseDecodable(
            of: MovieSearchResponseModel.self) { response in
                switch response.result {
                case .success(let result):
                    completionHandler(result.items)
                case .failure(let error):
                    print(error)
                }
            }
            .resume()
    }
}
