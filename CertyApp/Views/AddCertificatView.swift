//
//  AddCertificatView.swift
//  CertyApp
//
//  Created by Łukasz Adamczak on 14/10/2025.
//

import SwiftUI

struct AddCertificatView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var id: String = UUID().uuidString
    @State private var title: String = ""
    @State private var platform: String = ""
    @State private var date: Date = Date()
    @State private var category: String = ""
    @State private var imageData: Data?
    
    var onSave: (String, String, Date, String, Data?) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section("Informacje") {
                    TextField("Tytył certyfikatu", text: $title)
                    TextField("Platform", text: $platform)
                    DatePicker("Data", selection: $date)
                    TextField("Kategoria", text: $category)
                    HStack {
                        Text("Miniaturka")
                        ImagePicker(selectedImageData: $imageData)
                    }
                }
            }
            .navigationTitle("Dodaj certyfikat")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Anuluj") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Zapisz") {
                        guard !title.isEmpty else { return }
                        onSave(title, platform, date, category, imageData)
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
}

//#Preview {
//    AddCertificatView()
//}
