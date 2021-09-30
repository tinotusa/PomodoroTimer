//
//  TaskRowView.swift
//  PomodoroTimer
//
//  Created by Tino on 28/9/21.
//

import SwiftUI

struct TaskRowView: View {
    @EnvironmentObject var tasksModel: TasksModel
    
    @Binding var task: Task
    @State private var isEditing = false
    @FocusState private var focused: Bool
    
    var body: some View {
        HStack {
            Toggle("Mark completed", isOn: $task.isComplete)
                .toggleStyle(.radioCheckbox)
            if isEditing {
                TextField("name", text: $task.name) { isEditing in
                    self.isEditing = isEditing
                }
                .focused($focused)
                .task {
                    focused = true
                }
                
                Image(systemName: "pencil")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color("text"))
            } else {
                Text(task.name)
            }
            Spacer()
            deleteButton
        }
        .padding()
        .background(isEvenRow ? Color("background").opacity(0.2) : .clear)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation {
                isEditing = true
            }
            focused = true
        }
    }
}

private extension TaskRowView {
    var isEvenRow: Bool {
        if let index = tasksModel.firstIndex(of: task) {
            return index % 2 == 0
        }
        return false
    }
    
    var deleteButton: some View {
        Button {
            withAnimation {
                tasksModel.remove(task)
            }
        } label: {
            Image(systemName: "trash")
                .font(.title)
                .foregroundColor(Color("text"))
        }
    }
}

struct TaskRowView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("foreground")
                .ignoresSafeArea()
            TaskRowView(task: .constant(Task(name: "prewview name")))
                .environmentObject(TasksModel())
        }
        
    }
}
