//
//  TimeInputView.swift
//  PomodoroTimer
//
//  Created by Tino on 28/9/21.
//

import SwiftUI
import Combine

extension Text {
    func largeBoldFont(isSmallDevice: Bool = false) -> Text {
        self
            .bold()
            .font(isSmallDevice ? .title : .largeTitle)
            .foregroundColor(Color("text"))
    }
}

struct TimeInputView: View {
    @Binding var hours: String
    @Binding var minutes: String
    @Binding var seconds: String
    
    var body: some View {
        HStack(spacing: isSmallDevice ? 0 : 10){
            TimeInputBox(type: .hours, text: $hours)
            Text(":")
                .largeBoldFont(isSmallDevice: isSmallDevice)
            TimeInputBox(type: .minutes, text: $minutes)
            Text(":")
                .largeBoldFont(isSmallDevice: isSmallDevice)
            TimeInputBox(type: .seconds, text: $seconds)
        }
        .foregroundColor(Color("text"))
    }
    
    struct TimeInputBox: View {
        enum InputType: String {
            case hours = "HH"
            case minutes = "MM"
            case seconds = "SS"
        }
        
        var type: InputType
        @Binding var text: String
        var width: Double = 90.0
        var height: Double = 70.0
        
        private let radius = 15.0
        private let smallWidth = 55.0
        private let smallHeight = 20.0

        @State private var isEditing = false
        
        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: radius)
                    .fill(Color("foreground"))
                
                TextField(type.rawValue, text: $text) { isEditing in
                    if !isEditing {
                        text = String(format: "%02d", Int(text) ?? 0)
                    }
                }
                .onChange(of: text) { text in
                    if text.count > 2 {
                        self.text = String(text.prefix(2))
                    }
                }
                .onReceive(Just(text)) { newValue in
                    let filtered = newValue.filter { "0123456789".contains($0) }
                    if newValue != filtered {
                        self.text = filtered
                    }
                }
                .foregroundColor(Color("text"))
                .font(isSmallDevice ? .system(size: 12) : .largeTitle)
                .keyboardType(.numberPad)
                .padding()
            }
            .frame(
                width:  isSmallDevice ? smallWidth : width,
                height: isSmallDevice ? smallHeight : height
            )
        }
    }
}

struct TimeInputView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("background")
        
            TimeInputView(
                hours: .constant("00"),
                minutes: .constant("02"),
                seconds: .constant("30")
            )
        }
            .previewLayout(.fixed(width: 400, height: 100))
    }
}
