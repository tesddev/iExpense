//
//  Expenses.swift
//  iExpense
//
//  Created by GIGL-MAC on 18/04/2024.
//

import Foundation
import Observation

@Observable
class Expenses {
    var items = [ExpenseItem](){
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
                personalItems = items.filter {$0.type == "Personal"}
                businessItems = items.filter {$0.type == "Business"}
            }
        }
    }
    
    var personalItems = [ExpenseItem]()
    
    var businessItems = [ExpenseItem]()
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }

        items = []
    }
}
