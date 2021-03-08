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
    
    var body: some View {
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
                    // TODO: -
                }) {
                    Text("保存")
                }
                Button(action: {
                    // TODO: -
                }) {
                    Text("閉じる")
                        .foregroundColor(.gray)
                }
            }
        }.padding(32)
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
