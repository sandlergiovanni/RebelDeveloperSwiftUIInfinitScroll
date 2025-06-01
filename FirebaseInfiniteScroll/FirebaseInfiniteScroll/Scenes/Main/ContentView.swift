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
        VStack {
            HStack {
                SimpleSearchField(textSearch: $textSearch)
                    .frame(maxWidth: .infinity)
                
                NavigationLink {
                    ContactView(contact: nil)
                } label: {
                    Image(systemName: "plus")
                        .foregroundStyle(.white)
                }
            }
            .padding()
            
            List {
                ForEach(list, id:\.safeId) { item in
                    SimpleLine(contact: item)
                        .onAppear() {
                            if contactList.last?.safeId == item.safeId {
                                fetchMoreData(next: pageSize)
                            }
                        }
                }
            }
            .scrollContentBackground(.hidden)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue.opacity(0.5))
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

#Preview {
    ContentView()
}
