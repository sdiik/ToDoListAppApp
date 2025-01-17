//
//  TimePickerView.swift
//  ToDoListApp
//
//  Created by ahmad shiddiq on 16/01/25.
//

import SwiftUI

struct TimePickerView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedTime: Date
    
    private var hours: [Int] {
        Array(7...11)
    }
    
    private var minutes: [Int] {
        Array(0...59)
    }
    
    @State private var selectedHour: Int = 9
    @State private var selectedMinute: Int = 0
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Set Time")
                .font(.headline)
                .padding(.top, 16)
            
            HStack(spacing: 8) {
                Picker("Hour", selection: $selectedHour) {
                    ForEach(hours, id: \.self) { hour in
                        Text(String(format: "%02d", hour))
                            .tag(hour)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 60, height: 150)
                .clipped()
                
                Text(":")
                    .font(.largeTitle)
                    .bold()
                    .frame(width: 20)
                
                Picker("Minute", selection: $selectedMinute) {
                    ForEach(minutes, id: \.self) { minute in
                        Text(String(format: "%02d", minute))
                            .tag(minute)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 60, height: 150)
                .clipped()
            }
            
            Spacer()
            
            
            HStack(spacing: 16) {
                Button("Cancel") {
                    dismiss()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .foregroundColor(.blue)
                
                Button("Save") {
                    dismiss()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.bottom, 16)
        }
        .onAppear {
            let calendar = Calendar.current
            selectedHour = calendar.component(.hour, from: selectedTime)
            selectedMinute = calendar.component(.minute, from: selectedTime)
        }
        .onChange(of: selectedHour) { _ in updateSelectedTime() }
        .onChange(of: selectedMinute) { _ in updateSelectedTime() }
        .frame(maxWidth: .infinity)
        .background(Color(.systemBackground))
        .cornerRadius(20)
        .shadow(radius: 10)
        .presentationDetents([.fraction(0.5)])
    }
    
    private func updateSelectedTime() {
        var components = Calendar.current.dateComponents([.year, .month, .day], from: selectedTime)
        components.hour = selectedHour
        components.minute = selectedMinute
        if let updatedDate = Calendar.current.date(from: components) {
            selectedTime = updatedDate
        }
    }
}
