//
//  CreateHabit.swift
//  iHabit
//
//  Created by Tiago Camargo Maciel dos Santos on 03/06/25.
//

import SwiftUI

struct CreateHabit: View {
    let icons = Icons()
    @State private var selectedIconName = "person"
    
    @Binding var habitModel: HabitModel
    @State private var titleText = ""
    @State private var descriptionText = ""
    @Environment(\.dismiss) var dismiss
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $titleText)
                TextField("Description", text: $descriptionText)
                Picker("Icon", selection: $selectedIconName) {
                    ForEach(icons.iconNames, id: \.self) { iconName in
                        Image(systemName: iconName)
                    }
                }
            }
            .alert("Missing information", isPresented: $showAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        createHabit()
                    } label: {
                        Text("Create habit")
                    }
                }
            }
        }
    }
    
    func createHabit() {
        
        if !titleText.isEmpty && !descriptionText.isEmpty {
            habitModel.habits.append(
                Habit(
                    title: titleText,
                    description: descriptionText,
                    iconName: selectedIconName
                )
            )
            dismiss()
        } else {
            showAlert.toggle()
            if titleText.isEmpty && !descriptionText.isEmpty {
                alertMessage = "Habit title is required."
            } else if descriptionText.isEmpty && !titleText.isEmpty {
                alertMessage = "Habit description is required."
            } else {
                alertMessage = "Habit title and description are required."
            }
        }
        
    }
}

#Preview {
    @State @Previewable var habitModel = HabitModel()
    CreateHabit(habitModel: $habitModel)
}
