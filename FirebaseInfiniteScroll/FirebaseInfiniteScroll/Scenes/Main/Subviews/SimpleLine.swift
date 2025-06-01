//
//  SimpleLine.swift
//  FirebaseInfiniteScroll
//
//  Created by Sandler Maciel on 01/06/25.
//

import SwiftUI

struct SimpleLine: View {
    let contact: Contact
    
    var body: some View {
        NavigationLink {
            ContactView(contact: contact)
        } label: {
            VStack(alignment: .leading) {
                Text(contact.nome)
                    .lineLimit(1)
                
                HStack {
                    Text(contact.email)
                        .foregroundStyle(.gray)
                        .font(.caption)
                        .bold()
                    
                    Spacer()
                    
                    Text(contact.celular)
                        .foregroundStyle(.gray)
                        .font(.caption)
                        .bold()
                }
            }
        }
    }
}
