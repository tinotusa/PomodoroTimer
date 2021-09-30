//
//  View+MenuButtonStyle.swift
//  PomodoroTimer
//
//  Created by Tino on 30/9/21.
//

import SwiftUI

struct MenuButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal)
            .padding(.vertical, 10)
            .foregroundColor(Color("text"))
            .background(Color("foreground"))
            .cornerRadius(20)
            .shadow(
                color: .black.opacity(0.2),
                radius: 5,
                x: 0,
                y: 5
            )
    }
}

extension View {
    func menuButtonStyle() -> some View {
        modifier(MenuButtonStyle())
    }
}
