//
//  ToDoListViewModel.swift
//  ToDoListApp
//
//  Created by ahmad shiddiq on 16/01/25.
//

import Foundation

class ToDoListViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var selectedTask: Task?
    @Published var showAddTaskView: Bool = false
    @Published var showDeleteConfirmation: Bool = false
    
    var groupedTasks: [Date: [Task]] {
        Dictionary(grouping: tasks) { task in
            Calendar.current.startOfDay(for: task.date)
        }
    }
    
    func addTask(_ task: Task) {
        tasks.append(task)
    }
    
    func updateTask(_ updatedTask: Task) {
        if let index = tasks.firstIndex(where: { $0.id == updatedTask.id }) {
            tasks[index] = updatedTask
        }
    }
    
    func toggleCompletion(for task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }
    
    func deleteTask(_ task: Task) {
        tasks.removeAll { $0.id == task.id }
    }
}
