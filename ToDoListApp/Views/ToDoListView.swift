//
//  ToDoListView.swift
//  ToDoListApp
//
//  Created by ahmad shiddiq on 16/01/25.
//

import SwiftUI

struct ToDoListView: View {
    @StateObject private var viewModel = ToDoListViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if !viewModel.tasks.isEmpty {
                    taskList
                } else {
                    noTaskView
                }
                tomorrowSection
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    headerView
                }
            }
            .sheet(isPresented: $viewModel.showAddTaskView) {
                AddTaskView { newTask in
                    viewModel.addTask(newTask)
                }
            }
            .confirmationDialog("Delete", isPresented: $viewModel.showDeleteConfirmation, titleVisibility: .visible) {
                deleteConfirmationButtons
            } message: {
                Text("Are you sure you want to delete?")
            }
        }
    }
    
    private var taskList: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 16) {
                ForEach(groupedTasks, id: \.key) { group in
                    Section(header: sectionHeader(for: group.key)) {
                        ForEach(group.value) { task in
                            TaskRowView(task: task) {
                                viewModel.toggleCompletion(for: task)
                            } onDelete: {
                                viewModel.deleteTask(task)
                            }
                        }
                    }
                }
            }
        }
    }
    
    private var noTaskView: some View {
        Text("No tasks available. Tap '+ New Task' to add one.")
            .foregroundColor(.gray)
            .padding()
    }
    
    private var tomorrowSection: some View {
        VStack(alignment: .leading) {
            Text("Tomorrow (\(formattedDate(Calendar.current.date(byAdding: .day, value: 1, to: Date())!)))")
                .font(.headline)
                .padding(.horizontal)
                .padding(.top, 20)
        }
    }
    
    private var headerView: some View {
        HStack {
            Text("To Do List")
                .font(.headline)
                .bold()
            Spacer()
            Button(action: {
                viewModel.showAddTaskView.toggle()
            }) {
                Text("+ New Task")
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.blue)
                    .cornerRadius(4)
            }
        }
        .padding(.horizontal)
    }
    
    private var deleteConfirmationButtons: some View {
        Group {
            Button("Delete", role: .destructive) {
                if let task = viewModel.selectedTask {
                    viewModel.deleteTask(task)
                }
            }
            Button("Cancel", role: .cancel) {}
        }
    }

    private func sectionHeader(for date: Date) -> some View {
        Text(formattedDate(date))
            .font(.headline)
            .padding(.leading)
            .foregroundColor(.gray)
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd MMMM yyyy"
        return formatter.string(from: date)
    }
    
    private var groupedTasks: [(key: Date, value: [Task])] {
        viewModel.groupedTasks.keys.sorted().map { date in
            (key: date, value: viewModel.groupedTasks[date] ?? [])
        }
    }
}
