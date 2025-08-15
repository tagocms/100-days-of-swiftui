//
//  AddView.swift
//  iExpense
//
//  Created by Tiago Camargo Maciel dos Santos on 20/05/25.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @State private var name = "Add expense"
    @State private var type = "Personal"
    @State private var value = 0.0
    let types = ["Personal", "Business"]
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(types, id:\.self) { type in
                        Text(type)
                    }
                }
                TextField("Value", value: $value, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(id: "Save", placement: .primaryAction) {
                    Button {
                        modelContext.insert(ExpenseItem(name: name, type: type, value: value))
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                }
                
                ToolbarItem(id: "Dismiss", placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Dismiss")
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    AddView()
}
