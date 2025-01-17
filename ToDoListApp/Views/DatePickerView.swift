//
//  DatePickerView.swift
//  ToDoListApp
//
//  Created by ahmad shiddiq on 16/01/25.
//

import SwiftUI

import SwiftUI

struct DatePickerView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedDate: Date
    
    @State private var currentMonth: Date = Date()
    
    private let calendar = Calendar.current
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 16) {
                Text("Set Date")
                    .font(.headline)
                    .padding(.top, geometry.safeAreaInsets.top + 16)
                
                HStack {
                    Button(action: {
                        withAnimation {
                            currentMonth = calendar.date(byAdding: .month, value: -1, to: currentMonth) ?? currentMonth
                        }
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20))
                            .padding()
                    }
                    
                    Spacer()
                    
                    Text(dateFormatter.string(from: currentMonth))
                        .font(.title3)
                        .bold()
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation {
                            currentMonth = calendar.date(byAdding: .month, value: 1, to: currentMonth) ?? currentMonth
                        }
                    }) {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 20))
                            .padding()
                    }
                }
                .padding(.horizontal)
                
                CalendarView(selectedDate: $selectedDate, currentMonth: $currentMonth)
                    .padding(.bottom)
                
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
                .padding(.bottom, geometry.safeAreaInsets.bottom + 16)
            }
            .frame(width: geometry.size.width)
            .background(Color(.systemBackground))
            .cornerRadius(20)
            .shadow(radius: 10)
            .presentationDetents([.fraction(0.5), .fraction(0.8)])
            .ignoresSafeArea(edges: [.bottom])
        }
    }
}
