//
//  CertificatesListView.swift
//  CertyApp
//
//  Created by Łukasz Adamczak on 14/10/2025.
//

import SwiftUI
import SwiftData

struct CertificatesListView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var vm = CertificatesViewModel()
    @State private var showAddSheet = false
    
    var body: some View {
        NavigationView {
            List {
                if vm.certificates.isEmpty {
                    Text("Brak certyfikatów - dodaj pierwszy.")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(vm.certificates, id: \.id) { cert in
                        CertificatRowView(cetificate: cert)
                    }
                    .onDelete(perform: delete)
                }
            }
            .navigationTitle("Moje Certyfikaty")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: { showAddSheet = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddSheet) {
                AddCertificatView { id, title, platform, date, category in
                    vm.add(id: UUID, title: title, platform: platform, date: date, category: category)
                    showAddSheet = false
                }
                .environment(\.modelContext, modelContext)
            }
        }
        .onAppear {
            vm.modelContext = modelContext
            vm.fetch()
            vm.seedIfEmpty()
        }
    }
    
    private func delete(at offsets: IndexSet) {
        for index in offsets {
            let cert = vm.certificates[index]
            vm.delete(cert)
        }
    }
}

#Preview {
    CertificatesListView()
}
