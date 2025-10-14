//
//  CertyAppApp.swift
//  CertyApp
//
//  Created by Łukasz Adamczak on 14/10/2025.
//

import SwiftUI
import SwiftData

@main
struct CertyAppApp: App {
    var body: some Scene {
        WindowGroup {
            CertificatesListView()
                .modelContainer(for: [Certificate.self])
        }
    }
}
