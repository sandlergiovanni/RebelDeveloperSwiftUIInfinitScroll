import SwiftUI
import FirebaseFirestore

struct ContentView: View {
    // MARK: Properties
    private let pageSize = 10
    @State private var limit = 1
    @State private var textSearch = ""
    @FirestoreQuery(collectionPath: AppCollections.userTasks, predicates:[.limit(to: 10)])
    private var todoList: [UserTasks]
    private var list: [UserTasks] {
        if textSearch.isEmpty {
            return todoList
        }
        return todoList.filter { $0.title.starts(with: textSearch) }
    }
            
    var body: some View {
        List {
            ForEach(list) { item in
                SimpleLine(task: item)
                    .onAppear() {
                        if todoList.last?.title == item.title {
                            fetchMoreData(next: pageSize)
                        }
                    }
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    insertNewRecord()
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
    private func insertNewRecord() {
        do {
            let newTask = UserTasks(title: "Título randômico: \(Int.random(in: 0...1000))")
            try Firestore.firestore()
                .collection(AppCollections.userTasks)
                .document()
                .setData(from: newTask)
        } catch {
            print("==> Erro ao gerar item: \(error.localizedDescription)")
        }
    }
    
    private func fetchMoreData(next: Int) {
        limit += next
        $todoList.predicates = [
            .order(by: "createdAt", descending: true),
            .limit(to: limit)
        ]
    }
}

struct SimpleLine: View {
    var task: UserTasks
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(task.title)
                .lineLimit(1)
            
            Text(task.createdAt, formatter: DateFormatter.displayMinutesAndSeconds)
                .foregroundStyle(.gray)
                .font(.caption)
                .bold()
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
