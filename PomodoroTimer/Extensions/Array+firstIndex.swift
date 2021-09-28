//
//  Array+firstIndex.swift
//  PomodoroTimer
//
//  Created by Tino on 28/9/21.
//

extension Array where Element: Identifiable {
    func firstIndex(of element: Element) -> Int? {
        self.firstIndex(where: { $0.id == element.id} )
    }
}
