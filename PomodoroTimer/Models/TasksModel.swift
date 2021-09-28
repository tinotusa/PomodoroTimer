//
//  TasksModel.swift
//  PomodoroTimer
//
//  Created by Tino on 28/9/21.
//

import Foundation

final class TasksModel: ObservableObject {
    // model
    @Published var tasks: [Task] = [] {
        didSet {
            save()
        }
    }
    
    init() {
        load()
    }
    
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
    
    func firstIndex(of task: Task) -> Int? {
        tasks.firstIndex(of: task)
    }
}

// MARK: - Load and Save functionality
private extension TasksModel  {
    static let saveKey = "TasksModel.UserDefaults"

    func save() {
        do {
            let data = try JSONEncoder().encode(tasks)
            UserDefaults.standard.set(data, forKey: Self.saveKey)
        } catch {
            print(error)
        }
    }
    
    func load() {
        do {
            guard let data = UserDefaults.standard.data(forKey: Self.saveKey) else { return }
            tasks = try JSONDecoder().decode([Task].self, from: data)
        } catch {
            print(error)
        }
    }
}
