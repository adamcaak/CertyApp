//
//  CertificatesViewModel.swift
//  CertyApp
//
//  Created by Łukasz Adamczak on 14/10/2025.
//

import Foundation
import SwiftData
import Combine

final class CertificatesViewModel: ObservableObject {
    @Published var certificates: [Certificate] = []
    var modelContext: ModelContext?

    init(context: ModelContext? = nil) {
        self.modelContext = context
    }

    // MARK: - Fetch all certificates
    func fetch() {
        guard let context = modelContext else { return }
        do {
            // prosty FetchDescriptor — można dodać sortowanie jeśli chcesz
            let descriptor = FetchDescriptor<Certificate>()
            let results = try context.fetch(descriptor)
            // update UI on main thread
            DispatchQueue.main.async {
                self.certificates = results
            }
        } catch {
            print("CertificatesViewModel.fetch() error:", error)
        }
    }

    // MARK: - Add
    func add(id: UUID, title: String, platform: String, date: Date, category: String, imageData: Data? = nil) {
        guard let context = modelContext else { return }
        let cert = Certificate(id: id, title: title, platform: platform, date: date, category: category, imageData: imageData)
        context.insert(cert)
        do {
            try context.save()
            fetch()
        } catch {
            print("CertificatesViewModel.add() save error:", error)
        }
    }

    // MARK: - Delete
    func delete(_ certificate: Certificate) {
        guard let context = modelContext else { return }
        context.delete(certificate)
        do {
            try context.save()
            fetch()
        } catch {
            print("CertificatesViewModel.delete() save error:", error)
        }
    }

    // MARK: - Seed (sample data)
    func seedIfEmpty() {
        guard let context = modelContext else { return }
        do {
            let descriptor = FetchDescriptor<Certificate>()
            let existing = try context.fetch(descriptor)
            if existing.isEmpty {
                // używamy add(...) żeby zapisać poprawnie i odświeżyć listę
                add(id: UUID(), title: "Swift Fundamentals", platform: "Udemy", date: Date(), category: "Swift")
                add(id: UUID(), title: "iOS Basics", platform: "Coursera", date: Calendar.current.date(byAdding: .day, value: -90, to: Date()) ?? Date(), category: "iOS")
            }
        } catch {
            print("CertificatesViewModel.seedIfEmpty() fetch error:", error)
        }
    }
}
