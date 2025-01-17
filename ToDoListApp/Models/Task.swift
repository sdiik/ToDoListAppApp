//
//  Task.swift
//  ToDoListApp
//
//  Created by ahmad shiddiq on 16/01/25.
//

import Foundation

struct Task: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var date: Date
    var includeTime: Bool
    var isCompleted: Bool = false
}
