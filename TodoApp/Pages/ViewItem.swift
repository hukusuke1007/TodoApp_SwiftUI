//
//  ViewItem.swift
//  TodoApp
//
//  Created by 中川祥平 on 2021/03/09.
//

import SwiftUI

struct ViewItem: Identifiable {
    let id = UUID()
    let view: AnyView
}

struct AlertItem: Identifiable {
    let id = UUID()
    let view: Alert
}
