//
//  FormView.swift
//  TodoApp
//
//  Created by 中川祥平 on 2021/03/08.
//

import SwiftUI

struct FormView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var viewModel: FormViewModel
    @State var alertItem: AlertItem?
    
    init(viewModel: FormViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Color.white
            VStack {
                HStack {
                    Text(viewModel.createdAt)
                        .foregroundColor(.gray)
                    Spacer()
                }
                TextField("入力してください", text: $viewModel.text,
                          onEditingChanged: { change in
                            print(change)
                          },
                          onCommit: {
                            print("onCommit")
                          }
                )
                .textFieldStyle(RoundedBorderTextFieldStyle())
                
            }
            .padding(32)
            
            VStack(spacing: 24) {
                Spacer()
                Button(action: {
                    viewModel.onSave { error in
                        hideKeyboard()
                        if let error = error {
                            print(error)
                            alertItem = AlertItem(
                                view: Alert(
                                    title: Text("TODO"),
                                    message: Text("保存に失敗しました"),
                                    dismissButton: .default(Text("OK"),
                                    action: {} )
                                )
                            )
                            return
                        }
                        alertItem = AlertItem(
                            view: Alert(
                                title: Text("TODO"),
                                message: Text("保存しました"),
                                dismissButton: .default(Text("OK"),
                                action: { self.dismiss() })
                            )
                        )
                    }
                }) {
                    Text("保存")
                        .bold()
                }.disabled(viewModel.disable)
                
                Button(action: {
                    dismiss()
                }) {
                    Text("閉じる")
                        .foregroundColor(.gray)
                }
            }.padding()
            
            /// ローディング
            if (viewModel.loading) {
                ZStack {
                    Color.black.opacity(0.1).ignoresSafeArea()
                    ProgressView()
                }
            }
        }.onTapGesture {
            hideKeyboard()
        }
        .alert(item: $alertItem) { $0.view }
    }
    
    private func dismiss() {
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            
        }.sheet(isPresented: .constant(true)) {
            FormView(viewModel: FormViewModel(todo: nil))
        }
    }
}
