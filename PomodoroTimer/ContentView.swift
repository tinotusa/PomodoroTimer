//
//  ContentView.swift
//  PomodoroTimer
//
//  Created by Tino on 27/9/21.
//

import SwiftUI


struct ContentView: View {
    @State private var hours = ""
    @State private var minutes = "25"
    @State private var seconds = "00"
    @State private var isCounting = false
    @StateObject var tasksModel = TasksModel()
    
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()

            VStack {
                CountdownTimer()
                TaskBox()
            }
            .padding(.horizontal)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDisplayName("Default mode")
            ContentView()
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark mode")
        }
        .environmentObject(TasksModel())
        .environmentObject(NotificationManager())
    }
}
