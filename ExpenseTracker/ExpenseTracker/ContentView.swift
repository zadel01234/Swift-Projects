//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Olufayo Emmanuel on 02/02/2026.
//
import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Expense.date, ascending: false)],
        animation: .default
    )
    private var expenses: FetchedResults<Expense>

    @State private var showAddExpense = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses) { expense in
                    VStack(alignment: .leading) {
                        Text(expense.category ?? "Unknown")
                            .font(.headline)

                        Text(expense.note ?? "")
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        Text("₦\(expense.amount, specifier: "%.2f")")
                            .font(.title3)
                            .bold()
                    }
                }
                .onDelete(perform: deleteExpense)
            }
            .navigationTitle("Expenses")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddExpense = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddExpense) {
                AddExpenseView()
            }
        }
    }

    private func deleteExpense(offsets: IndexSet) {
        withAnimation {
            offsets.map { expenses[$0] }.forEach(viewContext.delete)
            try? viewContext.save()
        }
    }
}
