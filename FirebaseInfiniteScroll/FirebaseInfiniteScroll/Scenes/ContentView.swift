import SwiftUI
import FirebaseFirestore

struct ContentView: View {
    private let pageSize = 10
    @State private var limit = 1
    
    @FirestoreQuery(collectionPath: AppCollections.userTasks, predicates:[.limit(to: 10)])
    private var todoList: [UserTasks]
        
    var body: some View {
        List {
            ForEach(todoList) { item in
                self.getLine(task: item)
                    .onAppear {
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
                Text("\(todoList.count)")
                    .bold()
            }
        }
        .refreshable {
            fetchMoreData(next: pageSize)
        }
    }
    
    // MARK: UI Methods
    private func getLine(task: UserTasks) -> some View {
        return VStack(alignment: .leading) {
            Text(task.title ?? "N/A")
                .lineLimit(1)
            
            if let date = task.createdAt {
                Text(date, formatter: DateFormatter.displayMinutesAndSeconds)
                    .foregroundStyle(.gray)
                    .font(.caption)
                    .bold()
            }
        }
    }
    
    // MARK: Custom Logic Methods
    private func insertNewRecord() {
        do {
            let newTask = UserTasks(title: "Titulo randomico: \(Int.random(in: 0...1000))")
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

#Preview {
    ContentView()
}
