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
    var modelContext: ModelContext? // ustawimy z View (z environment)

    init() {}

    // fetch - pobierz wszystkie certyfikaty
    func fetch() {
        guard let context = modelContext else { return }
        do {
            let query = Query<Certificate>()
            let results = try context.fetch(query)
            // fetch zwraca [Certificate]
            DispatchQueue.main.async {
                self.certificates = results
            }
        } catch {
            print("Fetch error:", error)
        }
    }

    // add - dodaj nowy certyfikat
    func add(title: String, platform: String, date: Date, category: String) {
        guard let context = modelContext else { return }
        let cert = Certificate(title: title, platform: platform, date: date, category: category)
        context.insert(cert)
        do {
            try context.save()
            fetch()
        } catch {
            print("Save error:", error)
        }
    }

    // delete - usuń certyfikat
    func delete(_ certificate: Certificate) {
        guard let context = modelContext else { return }
        context.delete(certificate)
        do {
            try context.save()
            fetch()
        } catch {
            print("Delete error:", error)
        }
    }

    // seed - przykładowe dane (przydatne w preview / na start)
    func seedIfEmpty() {
        guard let context = modelContext else { return }
        let q = Query<Certificate>()
        if (try? context.fetch(q))?.isEmpty ?? true {
            add(title: "Swift Fundamentals", platform: "Udemy", date: Date(), category: "Swift")
            add(title: "iOS Basics", platform: "Coursera", date: Date().addingTimeInterval(-60*60*24*90), category: "iOS")
        }
    }
}
