//
//  PomodoroTimerApp.swift
//  PomodoroTimer
//
//  Created by Tino on 27/9/21.
//

import SwiftUI

@main
struct PomodoroTimerApp: App {
    @StateObject var tasksModel = TasksModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(tasksModel)
        }
    }
}
