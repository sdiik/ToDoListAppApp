//
//  AddTaskViewModel.swift
//  ToDoListApp
//
//  Created by ahmad shiddiq on 16/01/25.
//

import Foundation

class AddTaskViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var date: Date = Date()
    @Published var includeTime: Bool = false
    @Published var time: Date = Date()
    
    var isSaveDisabled: Bool {
        return title.isEmpty || description.isEmpty
    }
    
    func getFinalDate() -> Date {
        if includeTime {
            let calendar = Calendar.current
            let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
            let timeComponents = calendar.dateComponents([.hour, .minute], from: time)
            var combinedComponents = DateComponents()
            combinedComponents.year = dateComponents.year
            combinedComponents.month = dateComponents.month
            combinedComponents.day = dateComponents.day
            combinedComponents.hour = timeComponents.hour
            combinedComponents.minute = timeComponents.minute
            return calendar.date(from: combinedComponents) ?? date
        } else {
            return date
        }
    }
    
    func createTask() -> Task {
        return Task(title: title, description: description, date: getFinalDate(), includeTime: includeTime)
    }
}
