//
//  SettingView.swift
//  TodoApp
//
//  Created by 中川祥平 on 2021/03/08.
//

import SwiftUI

struct SettingView: View {
    
    @ObservedObject private var viewModel: SettingViewModel
    
    init(viewModel: SettingViewModel = SettingViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        List {
            Section(header: Text("アプリ")) {
                ListTile(title: "バージョン", detail: viewModel.appVersion)
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle(Text("設定"), displayMode: .automatic)
    }
}

struct ListTile: View {
    let title: String
    let detail: String
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(detail)
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingView()
        }
    }
}
