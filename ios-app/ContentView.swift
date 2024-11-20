import SwiftUI

struct ContentView: View {
    @State private var tasks: [Task] = [] 
    @State private var newTaskName: String = "" 

    var body: some View {
        NavigationView {
            VStack {
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Add New Task")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    HStack {
                        TextField("Enter task name", text: $newTaskName)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadow(radius: 2)
                        
                        Button(action: {
                            addTask()
                        }) {
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .frame(width: 44, height: 44)
                                .background(Color.green)
                                .cornerRadius(22)
                                .shadow(radius: 2)
                        }
                    }
                }
                .padding()
                .background(Color.blue)
                .cornerRadius(12)
                .padding(.horizontal)
                .shadow(radius: 4)

                
                if tasks.isEmpty {
                    Spacer()
                    Text("No tasks yet!")
                        .foregroundColor(.gray)
                        .font(.title3)
                    Spacer()
                } else {
                    List {
                        ForEach(tasks) { task in
                            HStack {
                                Text(task.name)
                                    .strikethrough(task.isCompleted, color: .gray)
                                    .foregroundColor(task.isCompleted ? .gray : .primary)
                                    .font(.body)
                                Spacer()
                                Button(action: {
                                    toggleTaskCompletion(task)
                                }) {
                                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(task.isCompleted ? .green : .blue)
                                        .font(.title2)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                        .onDelete(perform: deleteTask)
                    }
                }
            }
            .navigationTitle("To-Do List")
        }
    }

    
    private func addTask() {
        guard !newTaskName.isEmpty else { return }
        let task = Task(id: UUID(), name: newTaskName, isCompleted: false)
        tasks.append(task)
        newTaskName = ""
    }

    
    private func toggleTaskCompletion(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }

    
    private func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}


struct Task: Identifiable {
    let id: UUID
    let name: String
    var isCompleted: Bool
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

