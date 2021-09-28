//
//  CountdownTimer.swift
//  PomodoroTimer
//
//  Created by Tino on 28/9/21.
//

import SwiftUI

struct CountdownTimer: View {
    @State private var hours = ""
    @State private var minutes = ""
    @State private var seconds = ""
    @State private var isCounting = false
    @State private var timeRemaining = 0
    @State private var trimAmount = 0.0
    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
    
    @EnvironmentObject var notificationManager: NotificationManager
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color("foreground").opacity(0.2), lineWidth: 5)
            
            Circle()
                .trim(from: trimAmount, to: 1)
                .stroke(Color("foreground"), lineWidth: 10)
                .rotationEffect(.degrees(-90))
                .rotation3DEffect(.degrees(180), axis: (0, 1, 0))
            
            
            VStack {
                if !isCounting {
                    TimeInputView(hours: $hours, minutes: $minutes, seconds: $seconds)
                } else {
                    Text("\(timeRemainingString)")
                        .font(.system(size: 80))
                        .foregroundColor(Color("text"))
                }
                playButton
            }
        }
        .onReceive(timer) { _ in
            if !isCounting { return }
            if  timeRemaining == 0 {
                isCounting = false
                // send notification
                return
            }
            
            timeRemaining -= 1
            withAnimation(.linear(duration: 1)) {
                trimAmount = Double(timeRemaining) / Double(timeSetInSeconds)
            }
        }
    }
}

private extension CountdownTimer {
    var timeSetInSeconds: Int {
        let hours = (Int(hours) ?? 0) * 60 * 60
        let minutes = (Int(minutes) ?? 0) * 60
        let seconds = Int(seconds) ?? 0
        
        return hours + minutes + seconds
    }
    
    var timeRemainingString: String {
        let hours = timeRemaining / (60 * 60)
        var remainingSeconds = timeRemaining % (60 * 60)
        let minutes = remainingSeconds / 60
        remainingSeconds = remainingSeconds % 60
        let seconds = remainingSeconds
        
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    var playButton: some View {
        Button {
            notificationManager.requestAuthorization()
            isCounting.toggle()
            if !isCounting {
                let hours = timeRemaining / (60 * 60)
                var remainingSeconds = timeRemaining % (60 * 60)
                let minutes = remainingSeconds / 60
                remainingSeconds = remainingSeconds % 60
                let seconds = remainingSeconds
                self.hours = hours == 0 ? "" : String(format: "%02d", hours)
                self.minutes = minutes == 0 ? "" : String(format: "%02d", minutes)
                self.seconds = seconds == 0 ? "" : String(format: "%02d", seconds)
                notificationManager.removeNotification()
            } else {
                timeRemaining = timeSetInSeconds
                notificationManager.addNotification(timeInterval: Double(timeRemaining))
            }
        } label: {
            Image(systemName: isCounting ? "pause.fill" : "play.fill")
                .resizable()
                .foregroundColor(Color("foreground"))
                .frame(width: 60, height: 60)
                .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 7)
        }
        .disabled(timeSetInSeconds == 0)
    }
}

struct CountdownTimer_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            CountdownTimer()
        }
        .environmentObject(NotificationManager())
        
    }
}
