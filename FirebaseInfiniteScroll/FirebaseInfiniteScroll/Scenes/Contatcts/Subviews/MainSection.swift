//
//  MainSection.swift
//  FirebaseInfiniteScroll
//
//  Created by Sandler Maciel on 01/06/25.
//

import SwiftUI

struct MainSection: View {
    @Binding var nome: String
    @Binding var celular: String
    @Binding var email: String
    
    var body: some View {
        Section("Dados do Contato:") {
            TextField(text: $nome) {
                Text("Nome")
                    .font(.headline)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding()
            }
            
            TextField(text: $celular) {
                Text("Celular")
                    .font(.headline)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding()
            }
            
            TextField(text: $email) {
                Text("E-Mail")
                    .font(.headline)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding()
            }
        }
    }
}
