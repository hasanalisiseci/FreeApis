//
//  ApiViewModel.swift
//  FreeApis
//
//  Created by Hasan Ali Şişeci on 11.09.2022.
//

import FirebaseFirestore
import Foundation

class ApiViewModel: ObservableObject {
    private let service: ApiService
    private let db = Firestore.firestore()

    @Published var apiList: FreeApiModel?
    @Published var categoryList: [String] = ["All"]
    @Published var apiListIsCompleted: Bool?
    @Published var categoryListIsCompleted: Bool?

    init(service: ApiService) {
        self.service = service
        fetchApiList()
        fetchCategories()
    }

    func fetchApiList() {
        service.fetchItem(path: .entries) { response, isCompleted in
            self.apiList = response
            self.apiListIsCompleted = isCompleted
        }
    }

    func fetchCategories() {
        service.fetchCategories(path: .categories) { categories, isCompleted in
            self.categoryList += categories.categories
            self.categoryListIsCompleted = isCompleted
        }
    }

    func clearName(name: String) -> String {
        var returnStr = ""
        returnStr = name.replacingOccurrences(of: "\\", with: "", options: NSString.CompareOptions.literal, range: nil)
        returnStr = returnStr.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range: nil)
        returnStr = returnStr.replacingOccurrences(of: "/", with: "", options: NSString.CompareOptions.literal, range: nil)
        return returnStr
    }
}
