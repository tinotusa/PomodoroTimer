//
//  TasksModel.swift
//  PomodoroTimer
//
//  Created by Tino on 28/9/21.
//

import Foundation

final class TasksModel: ObservableObject {
    // model
    @Published var tasks: [Task] = []
    
    // MARK: - Computed properties
    var totalTasks: Int {
        tasks.count
    }
    
    var completeTasks: Int {
        tasks.filter { $0.isComplete }.count
    }
    
    var isEmpty: Bool {
        return tasks.isEmpty
    }
    
    // MARK: Functions
    func add(_ task: Task) {
        tasks.append(task)
    }
    
    func remove(_ task: Task) {
        if let index = tasks.firstIndex(of: task) {
            tasks.remove(at: index)
        }
    }
    
    func delete(offsets: IndexSet) {
        
    }
}

extension Array where Element: Identifiable {
    func firstIndex(of element: Element) -> Int? {
        self.firstIndex(where: { $0.id == element.id} )
    }
}
