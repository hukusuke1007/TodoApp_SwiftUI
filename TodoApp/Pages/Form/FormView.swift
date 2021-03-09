//
//  FormView.swift
//  TodoApp
//
//  Created by 中川祥平 on 2021/03/08.
//

import SwiftUI

struct FormView: View {
    
    @State var text: String = ""
    @State var createdAt: String = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color.white
            VStack {
                HStack {
                    Text(createdAt)
                        .foregroundColor(.gray)
                    Spacer()
                }
                TextField("入力してください", text: $text,
                          onEditingChanged: { change in
                            
                          },
                          onCommit: {
                            
                          }
                )
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.top, 8)
                .padding(.bottom, 24)
                
                VStack(spacing: 24) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("保存")
                    }
                    Button(action: {
                        dismiss()
                    }) {
                        Text("閉じる")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(32)
        }.onTapGesture {
            hideKeyboard()
        }
    }
    
    private func dismiss() {
        self.presentationMode.wrappedValue.dismiss()
        hideKeyboard()
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            
        }.sheet(isPresented: .constant(true)) {
            FormView()
        }
    }
}
