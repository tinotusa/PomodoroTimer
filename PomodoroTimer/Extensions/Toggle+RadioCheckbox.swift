//
//  Toggle+RadioCheckBox.swift
//  PomodoroTimer
//
//  Created by Tino on 28/9/21.
//

import SwiftUI

struct RadioCheckbox: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle.fill")
            .resizable()
            .frame(width: 30, height: 30)
            .foregroundColor(Color("background"))
            .onTapGesture {
                configuration.isOn.toggle()
            }
    }
}

extension ToggleStyle where Self == RadioCheckbox {
    static var radioCheckbox: RadioCheckbox {
        RadioCheckbox()
    }
}
