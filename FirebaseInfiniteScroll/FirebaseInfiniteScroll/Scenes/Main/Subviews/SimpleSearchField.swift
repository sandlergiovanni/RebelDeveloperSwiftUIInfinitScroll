//
//  SimpleSearchField.swift
//  FirebaseInfiniteScroll
//
//  Created by Sandler Maciel on 01/06/25.
//

import SwiftUI

struct SimpleSearchField: View {
    @Binding var textSearch: String
    
    var body: some View {
        HStack {
            TextField(text: $textSearch) {
                Text("Pesquisar...")
                    .tint(.white)
            }
            .frame(maxWidth: .infinity)
            .padding(10)
            .background(.white)
            .cornerRadius(10.0)
            .frame(height: 24)
        }
    }
}

#Preview {
    VStack {
        SimpleSearchField(textSearch: .constant(""))
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.gray)
}
