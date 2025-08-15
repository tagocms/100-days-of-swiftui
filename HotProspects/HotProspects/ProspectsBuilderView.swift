//
//  ProspectsBuilderView.swift
//  HotProspects
//
//  Created by Tiago Camargo Maciel dos Santos on 25/07/25.
//

import SwiftUI

struct ProspectsBuilderView: View {
    let filter: FilterType
    @State private var sortDescriptor = [
        SortDescriptor(\Prospect.name, order: .forward),
        SortDescriptor(\Prospect.dateAdded, order: .forward)
    ]
    
    var body: some View {
        NavigationStack {
            ProspectsView(filter: filter, sortDescriptor: sortDescriptor)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu("Order by", systemImage: "arrow.up.arrow.down") {
                            Picker("Order by", selection: $sortDescriptor) {
                                Text("Date")
                                    .tag(
                                        [
                                            SortDescriptor(\Prospect.dateAdded, order: .reverse),
                                            SortDescriptor(\Prospect.name, order: .forward)
                                        ]
                                    )
                                
                                Text("Name")
                                    .tag(
                                        [
                                            SortDescriptor(\Prospect.name, order: .forward),
                                            SortDescriptor(\Prospect.dateAdded, order: .reverse)
                                        ]
                                    )
                            }
                        }
                    }
                }
        }
    }
    
    init(filter: FilterType) {
        self.filter = filter
    }
}

enum FilterType {
    case none, contacted, uncontacted
}

#Preview {
    ProspectsBuilderView(filter: .none)
}
