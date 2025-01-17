//
//  TaskDetailView.swift
//  ToDoListApp
//
//  Created by ahmad shiddiq on 17/01/25.
//

import SwiftUI

struct TaskDetailView: View {
    @State var task: Task
    let onSave: (Task) -> Void
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Group {
                    Text("Title")
                        .font(.headline)
                    TextField("Enter task title", text: $task.title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.bottom, 8)
                    
                    Text("Description")
                        .font(.headline)
                    TextField("Enter task description", text: $task.description)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.bottom, 8)
                }
                
                Group {
                    Text("Date")
                        .font(.headline)
                    DatePicker("Select date", selection: $task.date, displayedComponents: [.date])
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding(.bottom, 8)
                    
                    if task.includeTime {
                        Text("Time")
                            .font(.headline)
                        DatePicker("Select time", selection: $task.date, displayedComponents: [.hourAndMinute])
                            .datePickerStyle(WheelDatePickerStyle())
                            .padding(.bottom, 8)
                    }
                }
                
                Spacer()
                
                Button(action: {
                    onSave(task)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save Changes")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }
            .padding()
        }
        .navigationTitle("Edit Task")
        .navigationBarTitleDisplayMode(.inline)
    }
}
