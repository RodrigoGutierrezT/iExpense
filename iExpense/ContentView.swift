//
//  ContentView.swift
//  iExpense
//
//  Created by Rodrigo on 13-07-24.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
    let currency: String
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems){
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}

struct ExpenseAmount: ViewModifier {
    let amount: Double
    
    func body(content: Content) -> some View {
        if amount <= 10 {
            return content
                .foregroundColor(.green)
                .font(.headline)
        } else if amount <= 100 {
            return content
                .foregroundColor(.blue)
                .font(.headline)
        } else {
            return content
                .foregroundColor(.red)
                .font(.headline)
        }
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                expenses.items.contains(where: { $0.type == "Personal" }) ?
                Section("Personal") {
                    ForEach(expenses.items) { item in
                        if item.type == "Personal" {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                    Text(item.type)
                                }
                                
                                Spacer()
                                
                                Text(item.amount, format: .currency(code: item.currency))
                                    .modifier(ExpenseAmount(amount: item.amount))
                            }
                        }
                    }
                    .onDelete(perform: removeItems)
                } : nil
                
                expenses.items.contains(where: { $0.type == "Business" }) ?
                Section("Business") {
                    ForEach(expenses.items) { item in
                        if item.type == "Business" {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                    Text(item.type)
                                }
                                
                                Spacer()
                                
                                Text(item.amount, format: .currency(code: item.currency))
                                    .modifier(ExpenseAmount(amount: item.amount))
                            }
                        }
                    }
                    .onDelete(perform: removeItems)
                } : nil
            }
            .navigationTitle("iExpense")
            .toolbar {
                NavigationLink(destination: AddView(expenses: expenses)) {
                    Image(systemName: "plus")
                }
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
