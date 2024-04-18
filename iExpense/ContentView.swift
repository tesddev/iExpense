//
//  ContentView.swift
//  iExpense
//
//  Created by Tes on 25/03/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    if !expenses.personalItems.isEmpty {
                        Section("Personal") {
                            ForEach(expenses.personalItems) { item in
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(item.name)
                                            .font(.headline)
                                        Text(item.type)
                                    }
                                    
                                    Spacer()
                                    Text(item.amount, format: .currency(code: "USD"))
                                }
                            }
                            .onDelete { indices in
                                let indexesToDelete = Array(indices)
                                if let firstIndex = indexesToDelete.first {
                                    removeItemsWith(expenses.personalItems[firstIndex].id)
                                }
                            }
                        }
                    }
                    if !expenses.businessItems.isEmpty {
                        Section("Business") {
                            ForEach(expenses.businessItems) { item in
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(item.name)
                                            .font(.headline)
                                        Text(item.type)
                                    }
                                    
                                    Spacer()
                                    Text(item.amount, format: .currency(code: "USD"))
                                }
                            }
                            .onDelete { indices in
                                let indexesToDelete = Array(indices)
                                if let firstIndex = indexesToDelete.first {
                                    removeItemsWith(expenses.businessItems[firstIndex].id)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("iExpense")
            }
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    func removeItemsWith(_ id: UUID) {
        expenses.items = expenses.items.filter {$0.id != id}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
