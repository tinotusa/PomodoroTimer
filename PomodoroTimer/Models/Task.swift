//
//  Task.swift
//  PomodoroTimer
//
//  Created by Tino on 28/9/21.
//

import Foundation

struct Task: Codable, Identifiable {
    let id = UUID()
    var name: String
    var isComplete: Bool = false
    
    // added this to silence the warning about id
    enum CodingKeys: CodingKey {
        case name, isComplete
    }
}
