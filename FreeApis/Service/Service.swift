//
//  Service.swift
//  FreeApis
//
//  Created by Hasan Ali Şişeci on 11.09.2022.
//

import Alamofire
import Foundation

protocol ApiService {
    func fetchItem(path: ApiPaths, onSuccess: @escaping (FreeApiModel, Bool) -> Void)
    func fetchCategories(path: ApiPaths, onSuccess: @escaping (Categories, Bool) -> Void)
}

enum ApiPaths: String {
    case entries
    case categories
    case random
}

class Service: ApiService {
    private let baseUrl: String = "https://api.publicapis.org/"

    func fetchItem(path: ApiPaths, onSuccess: @escaping (FreeApiModel, Bool) -> Void) {
        AF.request(baseUrl + path.rawValue).responseDecodable(of: FreeApiModel.self) { response in
            guard let value = response.value else { return }
            onSuccess(value, true)
        }
    }

    func fetchCategories(path: ApiPaths, onSuccess: @escaping (Categories, Bool) -> Void) {
        AF.request(baseUrl + path.rawValue).responseDecodable(of: Categories.self) { response in
            guard let value = response.value else { return }
            onSuccess(value, true)
        }
    }
}
