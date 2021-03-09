//
//  FirebaseAuthRepository.swift
//  TodoApp
//
//  Created by 中川祥平 on 2021/03/10.
//

import FirebaseAuth

protocol FirebaseAuthRepository: class {
    var logging: Bool { get }
    var userId: String? { get }
    func signInAnonymously(completion: ((AuthDataResult?, Error?) -> Void)?)
}

final class FirebaseAuthRepositoryImpl: FirebaseAuthRepository {
    
    private let auth: Auth
    
    init(auth: Auth = Auth.auth()) {
        self.auth = auth
    }
    
    var logging: Bool {
        return auth.currentUser != nil
    }
    var userId: String? {
        return auth.currentUser?.uid
    }
    
    func signInAnonymously(completion: ((AuthDataResult?, Error?) -> Void)? = nil) {
        auth.signInAnonymously(completion: completion)
    }
}

