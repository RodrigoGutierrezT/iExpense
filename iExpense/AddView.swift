//
//  AddView.swift
//  iExpense
//
//  Created by Rodrigo on 14-07-24.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name = "Expense Name"
    @State private var type = "Personal"
    @State private var amount = 0.0
    @State private var currency = "USD"
    
    let types = ["Business", "Personal"]
    let currencyList = ["USD", "CLP"]
    
    let expenses: Expenses
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                Picker("Currency", selection: $currency) {
                    ForEach(currencyList, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: currency))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(placement: .confirmationAction){
                    Button("Save") {
                        let item = ExpenseItem(name: name, type: type, amount: amount, currency: currency)
                        expenses.items.append(item)
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("cancel") {
                        dismiss()
                    }
                    .foregroundStyle(.red)
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    AddView(expenses: Expenses())
}
