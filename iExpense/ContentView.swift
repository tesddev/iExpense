//
//  ContentView.swift
//  iExpense
//
//  Created by GIGL-MAC on 25/03/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(expenses.items) { item in
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
                    .onDelete(perform: removeItems)
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
