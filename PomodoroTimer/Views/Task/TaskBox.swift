//
//  TaskBox.swift
//  PomodoroTimer
//
//  Created by Tino on 28/9/21.
//

import SwiftUI

struct TaskBox: View {
    @EnvironmentObject var tasksModel: TasksViewModel
    
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
                }
                Spacer()
            }
        }
        .frame(height: isSmallDevice ? 300 : 400)
        .font(isSmallDevice ? .system(size: 20) : .title)
    }
}

private extension TaskBox {
    var header: some View {
        HStack {
            Text("Tasks")
            Spacer()
            Text("\(tasksModel.completeTasks)/\(tasksModel.totalTasks)")
            addButton
        }
        .padding()
        .font(isSmallDevice ? .system(size: 14) : .title)
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
        Button {
            let task = Task(name: "new task")
            tasksModel.add(task)
        } label: {
            Image(systemName: "plus")
                .font(.subheadline)
                .menuButtonStyle()
        }
    }
}

struct TaskBox_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TaskBox()
            TaskBox()
                .previewDevice("iPod touch (7th generation)")
        }
        .environmentObject(TasksViewModel())
    }
}
