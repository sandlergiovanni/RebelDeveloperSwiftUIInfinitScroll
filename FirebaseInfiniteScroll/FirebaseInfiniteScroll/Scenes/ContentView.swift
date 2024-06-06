import SwiftUI
import FirebaseFirestore

struct ContentView: View {
    // MARK: Properties
    private let pageSize = 10
    @State private var limit = 1
    @State private var textSearch = ""
        
    private var list: [Contact] {
        if textSearch.isEmpty {
            return contactList
        }
        return contactList.filter { $0.nome.starts(with: textSearch) }
    }
    
    @FirestoreQuery(collectionPath: AppCollections.contacts, predicates:[.limit(to: 10)])
    private var contactList: [Contact]
            
    var body: some View {
        List {
            ForEach(list) { item in
                SimpleLine(contact: item)
                    .onAppear() {
                        if contactList.last?.id == item.id {
                            fetchMoreData(next: pageSize)
                        }
                    }
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                NavigationLink {
                    ContactView(contact: nil)
                } label: {
                    Image(systemName: "plus")
                }
            }
            
            ToolbarItem(placement: .principal) {
                SimpleSearchField(textSearch: $textSearch)
            }
        }
        .refreshable {
            fetchMoreData(next: pageSize)
        }
    }
    
    // MARK: Custom Logic Methods
    private func fetchMoreData(next: Int) {
        limit += next
        $contactList.predicates = [
            .order(by: "nome", descending: false),
            .limit(to: limit)
        ]
    }
}

struct SimpleLine: View {
    var contact: Contact
    
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

struct SimpleSearchField: View {
    @Binding var textSearch: String
    
    var body: some View {
        HStack {
            TextField(text: $textSearch) {
                Text("Pesquisar...")
                    .tint(.white)
            }
            .padding(10)
            .background(.white)
            .cornerRadius(10.0)
            .frame(height: 24)
        }
    }
}

#Preview {
    ContentView()
}
