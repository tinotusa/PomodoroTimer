//
//  ContentView.swift
//  PomodoroTimer
//
//  Created by Tino on 27/9/21.
//

import SwiftUI


struct ContentView: View {
    @StateObject var tasksModel = TasksModel()

    @State private var hours = ""
    @State private var minutes = ""
    @State private var seconds = ""
    @State private var isCounting = false

    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()

                VStack {
                    CountdownTimer(
                        hours: $hours,
                        minutes: $minutes,
                        seconds: $seconds,
                        isCounting: $isCounting
                    )
                    HStack {
                        restButton
                        Spacer()
                        defaultTimeButton
                    }
                    TaskBox()
                }
                .padding(.horizontal)
        }
    }
}

private extension ContentView {
    func setTime(hours: Int = 0, minutes: Int = 0, seconds: Int = 0) {
        isCounting = false
        self.hours = hours.isZero ? "" : String(format: "%02d", hours)
        self.minutes = minutes.isZero ? "" : String(format: "%02d", minutes)
        self.seconds = seconds.isZero ? "" : String(format: "%02d", seconds)
    }
    
    var restButton: some View {
        Menu {
            Button("5 minutes") { setTime(minutes: 5) }
            Button("10 minutes") { setTime(minutes: 10) }
            Button("20 minutes") { setTime(minutes: 20) }
        } label: {
            Text("Rest")
                .menuButtonStyle()
        }
    }
    
    var defaultTimeButton: some View {
        Menu {
            Button("25 minutes") { setTime(minutes: 25) }
            Button("40 minutes") { setTime(minutes: 40) }
            Button("1 hour") { setTime(hours: 1) }
        } label: {
            Text("Session time")
                .menuButtonStyle()
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
