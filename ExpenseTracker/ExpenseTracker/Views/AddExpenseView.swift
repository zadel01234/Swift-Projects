//
//  AddExpenseView.swift
//  ExpenseTracker
//
//  Created by Olufayo Emmanuel on 02/02/2026.
//

import Foundation
import SwiftUI

struct AddExpenseView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @State private var amount = ""
    @State private var category = "Food"
    @State private var note = ""
    @State private var date = Date()

    let categories = ["Food", "Transport", "Data", "clothes", "Rent", "Other"]

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Amount")) {
                    TextField("Enter amount", text: $amount)
                        .keyboardType(.decimalPad)
                }

                Section(header: Text("Category")) {
                    Picker("Category", selection: $category) {
                        ForEach(categories, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section(header: Text("Note")) {
                    TextField("Optional note", text: $note)
                }

                Section(header: Text("Date")) {
                    DatePicker("Select date", selection: $date, displayedComponents: .date)
                }
            }
            .navigationTitle("Add Expense")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveExpense()
                    }
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }

    private func saveExpense() {
        let newExpense = Expense(context: viewContext)
        newExpense.id = UUID()
        newExpense.amount = Double(amount) ?? 0
        newExpense.category = category
        newExpense.note = note
        newExpense.date = date

        try? viewContext.save()
        dismiss()
    }
}
