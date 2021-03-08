//
//  HomeView.swift
//  TodoApp
//
//  Created by 中川祥平 on 2021/03/08.
//

import SwiftUI

struct HomeView: View {
    @State var items: [Todo] = []
    @State var showingSetting = false
    
    var body: some View {
        NavigationView {
            ZStack {
                /// リスト
                List {
                    ForEach(items) { item in
                        HStack {
                            Text(item.text)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        items.remove(atOffsets: indexSet)
                    })
                }
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
        }.onAppear {
            for i in 0..<20 {
                items.append(Todo(text: "\(i)"))
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
