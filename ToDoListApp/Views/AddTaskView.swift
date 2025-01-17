//
//  AddTaskView.swift
//  ToDoListApp
//
//  Created by ahmad shiddiq on 16/01/25.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var description = ""
    @State private var date = Date()
    @State private var showDatePicker = false
    @State private var showTimePicker = false
    @State private var includeTime = false
    @State private var time = Date()
    
    var onAdd: (Task) -> Void
    
    var body: some View {
        NavigationView {
            VStack {
                taskForm
                
                actionButtons
                    .padding()
            }
            .navigationTitle("Add New Task")
            .sheet(isPresented: $showDatePicker) {
                DatePickerView(selectedDate: $date)
            }
            .sheet(isPresented: $showTimePicker) {
                TimePickerView(selectedTime: $time)
            }
        }
    }
    
    private var taskForm: some View {
        Form {
            titleSection
            descriptionSection
            dateSection
        }
    }
    
    private var titleSection: some View {
        Section(header: sectionHeader("Title")) {
            TextField("Title Task", text: $title)
                .textFieldStyle(DefaultTextFieldStyle())
        }
    }
    
    private var descriptionSection: some View {
        Section(header: sectionHeader("Description")) {
            TextField("Description Task", text: $description)
                .textFieldStyle(DefaultTextFieldStyle())
        }
    }
    
    private var dateSection: some View {
        Section(header: sectionHeader("Date")) {
            Button(action: { showDatePicker = true }) {
                formRow(icon: "calendar", text: date, style: .date)
            }
            
            Toggle(isOn: $includeTime.animation()) {
                formRow(icon: "clock", text: "Time")
            }
            
            if includeTime {
                Button(action: { showTimePicker = true }) {
                    formRow(icon: "clock", text: time, style: .time)
                }
            }
        }
    }
    
    private var actionButtons: some View {
        HStack {
            cancelButton
            saveButton
        }
    }
    
    private var cancelButton: some View {
        Button("Cancel") {
            dismiss()
        }
        .buttonStyle(CustomButtonStyle(backgroundColor: Color.gray.opacity(0.2), foregroundColor: .blue))
    }
    
    private var saveButton: some View {
        Button("Save") {
            let finalDate = includeTime ? combineDateAndTime(date: date, time: time) : date
            let newTask = Task(title: title, description: description, date: finalDate, includeTime: includeTime)
            onAdd(newTask)
            dismiss()
        }
        .buttonStyle(CustomButtonStyle(
            backgroundColor: title.isEmpty || description.isEmpty ? Color.gray : Color.blue,
            foregroundColor: .white
        ))
        .disabled(title.isEmpty || description.isEmpty)
    }
    
    private func combineDateAndTime(date: Date, time: Date) -> Date {
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
    }
    
    private func sectionHeader(_ text: String) -> some View {
        Text(text)
            .font(.headline)
            .fontWeight(.regular)
            .textCase(.none)
    }
    
    private func formRow(icon: String, text: String) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
            Text(text)
                .foregroundColor(.primary)
            Spacer()
        }
    }
    
    private func formRow(icon: String, text: Date, style: Text.DateStyle) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
            Text(text, style: style)
                .foregroundColor(.primary)
            Spacer()
        }
    }
}
