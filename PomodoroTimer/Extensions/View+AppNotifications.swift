//
//  View+AppNotifications.swift
//  PomodoroTimer
//
//  Created by Tino on 28/9/21.
//

import SwiftUI

extension View {
    func appDidEnterBackground(action: @escaping () -> Void) -> some View {
        self
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
                action()
            }
    }
    
    func appWillEnterForeground(action: @escaping () -> Void) -> some View {
        self
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                action()
            }
    }
}
