//
//  HomeView.swift
//  TodoApp
//
//  Created by 中川祥平 on 2021/03/08.
//

import SwiftUI
import Combine

struct HomeView: View {
    
    @State var showingSetting = false
    @ObservedObject private var viewModel: HomeViewModel
    @State var modal: ViewItem?
    
    init() {
        self.viewModel = HomeViewModel()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                /// リスト
                List {
                    ForEach(viewModel.items) { item in
                        Button(action: {
                            modal = ViewItem(view: AnyView(FormView(todo: item)))
                        }) {
                            VStack {
                                Text(item.dateLabel)
                                    .foregroundColor(.gray)
                                Text(item.text)
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    .onDelete(perform: { indexSet in
                        if let index = indexSet.first {
                            viewModel.onDelete(index: index)
                        }
                    })
                }
                .listStyle(InsetGroupedListStyle())
                .navigationBarTitle(Text("ホーム"), displayMode: .automatic)
                .navigationBarItems(trailing: Button(action: {
                    showingSetting = true
                }) {
                    Image(systemName: "gearshape.fill")
                        .frame(width: 40, height: 40)
                        .imageScale(.large)
                        .foregroundColor(.black)
                })
                
                /// Fab
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            modal = ViewItem(view: AnyView(FormView()))
                        }) {
                            Image(systemName: "plus")
                                .frame(width: 48, height: 48)
                                .imageScale(.large)
                                .background(Color.black)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                                .shadow(radius: 2, x: 1, y: 1)
                        }
                    }.padding()
                }.padding()
                
                /// 画面遷移
                if (showingSetting) {
                    NavigationLink(
                        destination: SettingView(),
                        isActive: $showingSetting,
                        label: EmptyView.init
                    )
                }
            }
        }
        .sheet(item: $modal) { $0.view }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
