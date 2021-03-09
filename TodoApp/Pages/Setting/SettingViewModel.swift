//
//  SettingViewModel.swift
//  TodoApp
//
//  Created by 中川祥平 on 2021/03/08.
//

import Foundation

final class SettingViewModel: ObservableObject {
    
    private let bundleRepository: BundleRepository
    
    init(bundleRepository: BundleRepository = BundleRepositoryImpl()) {
        self.bundleRepository = bundleRepository
    }
    
    var appVersion: String {
        return bundleRepository.appVersion
    }
}
