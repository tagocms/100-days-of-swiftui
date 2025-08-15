//
//  EditProspectView.swift
//  HotProspects
//
//  Created by Tiago Camargo Maciel dos Santos on 25/07/25.
//

import SwiftUI

struct EditProspectView: View {
    let prospect: Prospect
    @State private var name: String
    @State private var emailAddress: String
    @State private var isContacted: Bool
    @State private var isEditingDisabled = true
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $name)
                    .textContentType(.name)
                    .font(.title)
                
                TextField("E-mail address", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .font(.title)
                    .textInputAutocapitalization(.never)
                
                Toggle("Contacted", isOn: $isContacted)
                    .font(.title)
            }
            .disabled(isEditingDisabled)
            
            Section {
                Text("Added on \(prospect.dateAdded.formatted(date: .abbreviated, time: .shortened))")
            }
        }
        .navigationTitle("\(prospect.name)'s info")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if isEditingDisabled {
                    Button("Edit") {
                        isEditingDisabled.toggle()
                    }
                } else {
                    Button("Save changes") {
                        saveProspect()
                        isEditingDisabled.toggle()
                    }
                }
            }
        }
    }
    
    init(prospect: Prospect) {
        self.prospect = prospect
        self._name = State(initialValue: prospect.name)
        self._emailAddress = State(initialValue: prospect.emailAddress)
        self._isContacted = State(initialValue: prospect.isContacted)
    }
    
    func saveProspect() {
        prospect.name = name
        prospect.emailAddress = emailAddress
        prospect.isContacted = isContacted
    }
}

#Preview {
    let prospect = Prospect(name: "Tiago", emailAddress: "tagocms@gmail.com", isContacted: false)
    
    EditProspectView(prospect: prospect)
}
