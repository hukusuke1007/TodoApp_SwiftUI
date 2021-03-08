//
//  BundleRepository.swift
//  TodoApp
//
//  Created by 中川祥平 on 2021/03/08.
//

import Foundation

protocol BundleRepository: class {
    var appVersion: String { get }
}

final class BundleRepositoryImpl: BundleRepository {
    
    private let bundle: Bundle
    
    init(bundle: Bundle = Bundle.main) {
        self.bundle = bundle
    }
    
    var appVersion: String {
        if let result = bundle.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            return result
        }
        return ""
    }
}
