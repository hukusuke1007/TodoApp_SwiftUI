//
//  HomeView.swift
//  TodoApp
//
//  Created by 中川祥平 on 2021/03/08.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject private var viewModel: HomeViewModel
    @State private var showingSetting = false
    @State var modal: ViewItem?
    
    init(viewModel: HomeViewModel = HomeViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                /// リスト
                List {
                    ForEach(viewModel.items) { item in
                        Button(action: {
                            modal = ViewItem(view: AnyView(FormView(viewModel: FormViewModel(todo: item))))
                        }) {
                            VStack {
                                HStack {
                                    Text(item.dateLabel)
                                        .foregroundColor(.gray)
                                    Spacer()
                                }
                                HStack {
                                    Text(item.text)
                                        .foregroundColor(.black)
                                    Spacer()
                                }
                            }
                        }.onAppear {
                            /// paging
                            if (viewModel.items.isEmpty) {
                                return
                            }
                            guard let index = viewModel.items.lastIndex(where: { $0.id == item.id }) else {
                                return
                            }
                            let distance = viewModel.items.distance(from: index, to: viewModel.items.endIndex)
                            if (distance == 1) {
                                viewModel.onLoadMore()
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
                            modal = ViewItem(view: AnyView(FormView(viewModel: FormViewModel())))
                        }) {
                            Image(systemName: "plus")
                                .frame(width: 48, height: 48)
                                .imageScale(.large)
                                .background(Color.black)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                                .shadow(radius: 2, x: 1, y: 1)
                        }
                    }.padding(8)
                }.padding(8)
                
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
