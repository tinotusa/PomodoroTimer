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
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color("foreground"), lineWidth: 3)
            
            VStack {
                if !isCounting {
                    TimeInputView(hours: $hours, minutes: $minutes, seconds: $seconds)
                } else {
                    Text("remaining time here")
                }
                playButton
            }
        }
    }
    
    private var playButton: some View {
        Button {
            isCounting.toggle()
        } label: {
            Image(systemName: isCounting ? "pause.fill" : "play.fill")
                .resizable()
                .foregroundColor(Color("foreground"))
                .frame(width: 60, height: 60)
                .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 7)
        }
    }
}


struct CountdownTimer_Previews: PreviewProvider {
    static var previews: some View {
        CountdownTimer()
    }
}
