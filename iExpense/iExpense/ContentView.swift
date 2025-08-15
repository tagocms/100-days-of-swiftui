//
//  ContentView.swift
//  iExpense
//
//  Created by Tiago Camargo Maciel dos Santos on 19/05/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAddView = false
    @State private var sortOrder = [
        SortDescriptor(\ExpenseItem.name),
        SortDescriptor(\ExpenseItem.value)
    ]
    @State private var filterSelected = FilterOption.all

    var body: some View {
        NavigationStack {
            ExpenseListView(sortOrder: sortOrder, filterSelected: filterSelected.rawValue)
            .navigationTitle("iExpense")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort by", selection: $sortOrder) {
                            Text("Sort by name")
                                .tag(
                                    [
                                        SortDescriptor(\ExpenseItem.name),
                                        SortDescriptor(\ExpenseItem.value)
                                    ]
                                )
                            
                            Text("Sort by value")
                                .tag(
                                    [
                                        SortDescriptor(\ExpenseItem.value),
                                        SortDescriptor(\ExpenseItem.name)
                                    ]
                                )
                        }
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Menu("Filter", systemImage: "line.3.horizontal.decrease") {
                        Picker("Filter by", selection: $filterSelected) {
                            ForEach(FilterOption.allCases, id: \.self) { option in
                                Text(option.rawValue)
                            }
                        }
                    }
                }
                
                
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        AddView()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

enum FilterOption: String, CaseIterable {
    case all = "All"
    case personal = "Personal"
    case business = "Business"
}

#Preview {
    ContentView()
}
