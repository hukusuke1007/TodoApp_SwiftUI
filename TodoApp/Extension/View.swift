//
//  View.swift
//  TodoApp
//
//  Created by 中川祥平 on 2021/03/09.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

