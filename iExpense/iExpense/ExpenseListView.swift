//
//  ExpenseListView.swift
//  iExpense
//
//  Created by Tiago Camargo Maciel dos Santos on 18/06/25.
//

import SwiftData
import SwiftUI

struct ExpenseListView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [ExpenseItem]
    let filterSelected: String
    
    let currencyCode = Locale.current.currency?.identifier ?? "USD"
    
    var body: some View {
        List {
            if filterSelected == "All" || filterSelected == "Personal" {
                Section("Personal") {
                    ForEach(expenses) { item in
                        if item.type == "Personal" {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
                                }
                                
                                Spacer()
                                
                                Text(item.value, format: .currency(code: currencyCode))
                                    .foregroundStyle(valueColor(for: item.value))
                            }
                            .accessibilityElement(children: .ignore)
                            .accessibilityLabel("\(item.name), \(item.value.formatted(.currency(code: currencyCode)))")
                            .accessibilityHint(item.type)
                        }
                    }
                    .onDelete(perform: deleteItem)
                }
            }
            
            if filterSelected == "All" || filterSelected == "Business" {
                Section("Business") {
                    ForEach(expenses) { item in
                        if item.type == "Business" {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
                                }
                                
                                Spacer()
                                
                                Text(item.value, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                    .foregroundStyle(valueColor(for: item.value))
                            }
                            .accessibilityElement(children: .ignore)
                            .accessibilityLabel("\(item.name), \(item.value.formatted(.currency(code: currencyCode)))")
                            .accessibilityHint(item.type)
                        }
                    }
                    .onDelete(perform: deleteItem)
                }
            }
        }
    }
    
    init(sortOrder: [SortDescriptor<ExpenseItem>], filterSelected: String) {
        _expenses = Query(filter: #Predicate<ExpenseItem> { item in
            item.type == filterSelected || filterSelected == "All"
        }, sort: sortOrder)
        
        self.filterSelected = filterSelected
    }
    
    func deleteItem(at offsets: IndexSet) {
        for offset in offsets {
            modelContext.delete(expenses[offset])
        }
    }
    
    func valueColor(for value: Double) -> Color {
        switch value {
        case ..<10:
            .secondary
        case 10..<100:
            .yellow
        case 100..<1000:
            .orange
        default:
            .red
        }
    }
}

#Preview {
    ExpenseListView(sortOrder: [SortDescriptor(\ExpenseItem.name)], filterSelected: "All")
}
