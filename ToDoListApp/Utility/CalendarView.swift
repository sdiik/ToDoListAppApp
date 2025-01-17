//
//  CalendarView.swift
//  ToDoListApp
//
//  Created by ahmad shiddiq on 17/01/25.
//

import SwiftUI

struct CalendarView: View {
    @Binding var selectedDate: Date
    @Binding var currentMonth: Date
    
    private let calendar = Calendar.current
    private let daysOfWeek = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]
    
    private var daysInMonth: [Date] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: currentMonth) else { return [] }
        var days = [Date]()
        var currentDate = monthInterval.start
        while currentDate < monthInterval.end {
            days.append(currentDate)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate) ?? currentDate
        }
        return days
    }
    
    private func dayOffset(for date: Date) -> Int {
        let firstDayOfMonth = calendar.dateInterval(of: .month, for: currentMonth)?.start ?? currentMonth
        return calendar.component(.weekday, from: firstDayOfMonth) - 1
    }
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .font(.caption)
                        .frame(maxWidth: .infinity)
                }
            }
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 8) {
                ForEach(0..<dayOffset(for: currentMonth), id: \.self) { _ in
                    Text("")
                        .frame(maxWidth: .infinity)
                }
                
                ForEach(daysInMonth, id: \.self) { date in
                    Text("\(calendar.component(.day, from: date))")
                        .font(.body)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(8)
                        .background(calendar.isDate(date, inSameDayAs: selectedDate) ? Color.blue : Color.clear)
                        .foregroundColor(calendar.isDate(date, inSameDayAs: selectedDate) ? .white : .primary)
                        .clipShape(Circle())
                        .onTapGesture {
                            selectedDate = date
                        }
                }
            }
        }
        .padding(.horizontal)
    }
}
