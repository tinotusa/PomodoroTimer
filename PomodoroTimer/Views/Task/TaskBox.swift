//
//  TaskBox.swift
//  PomodoroTimer
//
//  Created by Tino on 28/9/21.
//

import SwiftUI

struct TaskBox: View {
    @EnvironmentObject var tasksModel: TasksModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(Color("foreground"))
                .shadow(
                    color: .black.opacity(0.3),
                    radius: 5,
                    x: 0,
                    y: 6
                )
            
            if tasksModel.isEmpty {
                emptyMessage
            }
            
            VStack(alignment: .trailing, spacing: 0) {
                header
                Divider()
                ScrollView(showsIndicators: false) {
                    ForEach($tasksModel.tasks) { $task in
                        TaskRowView(task: $task)
                    }
                    .onDelete(perform: tasksModel.delete)
                }
                Spacer()
            }
            addButton
                .padding()
                
        }
    }
}

private extension TaskBox {
    var header: some View {
        HStack {
            Text("Tasks")
            Spacer()
            Text("\(tasksModel.completeTasks)/\(tasksModel.totalTasks)")
        }
        .padding()
        .font(.title)
        .foregroundColor(Color("text"))
    }
    
    var emptyMessage: some View {
        VStack {
            Text("No tasks")
            Text("Tap to add a task")
        }
        .foregroundColor(Color("text").opacity(0.7))
    }
    
    var addButton: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button {
                    let task = Task(name: "new task")
                    tasksModel.add(task)
                } label: {
                    Image(systemName: "plus")
                        .padding()
                        .background(Color("foreground"))
                        .foregroundColor(Color("text"))
                        .clipShape(Circle())
                        .shadow(
                            color: .black.opacity(0.4),
                            radius: 5,
                            x: 0,
                            y: 6
                        )
                }
            }
        }
        
    }
}

struct TaskBox_Previews: PreviewProvider {
    static var previews: some View {
        TaskBox()
            .environmentObject(TasksModel())
    }
}
