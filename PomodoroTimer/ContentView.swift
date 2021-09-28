//
//  ContentView.swift
//  PomodoroTimer
//
//  Created by Tino on 27/9/21.
//

import SwiftUI

struct ContentView: View {
    @State private var hours = ""
    @State private var minutes = ""
    @State private var seconds = ""
    @State private var isCounting = false
    
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()

            VStack {
                CountdownTimer()
//                TaskBox()
            }
        }
    }
}

private extension ContentView {
    var countdownTime: some View {
        Text("20:00")
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDisplayName("Default mode")
        ContentView()
            .preferredColorScheme(.dark)
            .previewDisplayName("Dark mode")
    }
}
