//
//  CertificatesViewModel.swift
//  CertyApp
//
//  Created by Łukasz Adamczak on 14/10/2025.
//

import Foundation
import SwiftData
internal import Combine

class CertificatesViewModel: ObservableObject {
    @Published var certificates: [Certificate] = []
    var modelContext: ModelContext? //ustawiamy z View - z enviroment
    
    init() {}
    
    //fetch - pobierz wszystkie certyfikaty
    func fetch() {
        guard let context = modelContext else { return }
        do {
            let query = Query<Certificate>()
            let result = try context.fetch(query)
            //fetch zwraca [Certyficates]
            DispatchQueue.main.async {
                self.certificates = result
            }
        } catch {
            print("Error", error)
        }
    }
    //add - dodaj nowy certyfikat
    func add(title: String, platform: String, date: Date, category: String) {
        guard let context = modelContext else { return }
        let cert = Certificate(id: UUID(), title: title, platform: platform, date: date, category: category)
        context.insert(cert)
        do {
            try context.save()
            fetch()
        } catch {
            print("Save Error", error)
        }
    }
    
    //delete - usuń certyfikat
    func delete(_ certificate: Certificate) {
        guard let context = modelContext else { return }
        context.delete(certificate)
        do {
            try context.save()
            fetch()
        } catch {
            print("Delete Error", error)
        }
    }
    
    //seed - przykładowe dane przydatne w preview, na start
    func seedIfEmpty() {
        guard let context = modelContext else { return }
        let q = Query<Certificate>()
        if (try? context.fetch(q)).isEmpty == true {
            add(title: "Cleanroom Architecture", platform: "Udemy", date: Date(), category: "Swift")
            add(title: "The Swift Programming Language", platform: "Udemy", date: Date(), category: "Swift")
            add(title: "Networking with Swift", platform: "Udemy", date: Date(), category: "Swift")
        }
    }
}
