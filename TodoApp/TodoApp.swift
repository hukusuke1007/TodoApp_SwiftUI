//
//  TodoAppApp.swift
//  TodoApp
//
//  Created by 中川祥平 on 2021/02/26.
//

import SwiftUI
import Firebase
import Combine

@main
struct TodoApp: App {
    
    @ObservedObject private var viewModel: TodoAppViewModel
  
    init() {
        FirebaseApp.configure()
        viewModel = TodoAppViewModel()
    }
    
    var body: some Scene {
        WindowGroup {
            if (viewModel.running) {
                HomeView()
            }
        }
    }
}

final class TodoAppViewModel: ObservableObject {
    
    @Published private(set) var running: Bool = false
    private let firebaseAuthRepository: FirebaseAuthRepository
    
    init(firebaseAuthRepository: FirebaseAuthRepository = FirebaseAuthRepositoryImpl()) {
        self.firebaseAuthRepository = firebaseAuthRepository
        let logging = firebaseAuthRepository.logging
        if (!logging) {
            firebaseAuthRepository.signInAnonymously { [weak self] (result, error) in
                if let error = error { print(error); return; }
                self?.running = true
                print("signUp \(String(describing: self?.firebaseAuthRepository.userId))")
            }
        } else {
            running = true
            print("logging \(String(describing: firebaseAuthRepository.userId))")
        }
    }
}
