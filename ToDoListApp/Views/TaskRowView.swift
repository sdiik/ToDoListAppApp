//
//  TaskRowView.swift
//  ToDoListApp
//
//  Created by ahmad shiddiq on 16/01/25.
//

import SwiftUI

struct TaskRowView: View {
    var task: Task
    var onToggle: () -> Void
    var onDelete: () -> Void
    let onEdit: (Task) -> Void
    
    var body: some View {
        HStack {
            Button(action: onToggle) {
                Image(systemName: task.isCompleted ? "checkmark.square.fill" : "square")
                    .foregroundColor(task.isCompleted ? .blue : .gray)
            }
            
            VStack(alignment: .leading) {
                NavigationLink(destination: TaskDetailView(task: task, onSave: onEdit)) {
                    Text(task.title)
                        .strikethrough(task.isCompleted, color: .gray)
                        .foregroundColor(task.isCompleted ? .gray : .primary)
                        .font(.headline)
                }
                
                if task.includeTime {
                    Text(task.date, style: .time)
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
            }
            Spacer()
            
            Button(action: onDelete) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
        .padding(.horizontal)
    }
}
