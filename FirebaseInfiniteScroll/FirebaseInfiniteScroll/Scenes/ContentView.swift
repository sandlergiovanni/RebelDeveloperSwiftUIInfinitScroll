import SwiftUI
import FirebaseFirestore

struct AppCollections {
    static var userTasks = "userTasks"
}

struct ContentView: View {
    @State private var limit = 1
    
    @FirestoreQuery(collectionPath: AppCollections.userTasks, predicates:[.limit(to: 1)])
    private var todoList: [UserTasks]
    
    var body: some View {
        List {
            ForEach(todoList) { item in
                self.getLine(task: item)
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    try? Firestore.firestore()
                        .collection(AppCollections.userTasks)
                        .document()
                        .setData(from: UserTasks())
                } label: {
                    Image(systemName: "plus")
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("\(todoList.count)")
                    .bold()
            }
        }
    }
    
    func getLine(task: UserTasks) -> some View {
        Text(task.title ?? "Unavailable")
    }
    
    func addTask(task: UserTasks) throws {
        do {
            try Firestore.firestore()
                .collection(AppCollections.userTasks)
                .document()
                .setData(from: task)
        } catch {
            print("Erro ao inserir dados: \(error.localizedDescription)")
            throw error
        }
    }
}

#Preview {
    ContentView()
}
