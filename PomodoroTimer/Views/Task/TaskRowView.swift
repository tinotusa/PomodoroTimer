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
    
    var body: some View {
        HStack {
            Toggle("Mark completed", isOn: $task.isComplete)
                .toggleStyle(.radioCheckbox)
            if isEditing {
                TextField("name", text: $task.name) { isEditing in
                    self.isEditing = isEditing
                }
            } else {
                Text(task.name)
            }
            Spacer()
            deleteButton
        }
        .padding(.bottom)
        .padding(.horizontal)
        .onTapGesture {
            isEditing = true
        }
    }
}

private extension TaskRowView {
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
        TaskRowView(task: .constant(Task(name: "prewview name")))
            .environmentObject(TasksModel())
    }
}
