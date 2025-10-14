//
//  Certificate.swift
//  CertyApp
//
//  Created by Łukasz Adamczak on 14/10/2025.
//

import Foundation
import SwiftData

@Model
final class Certificate: Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
    var title: String
    var platform: String
    var date: Date
    var category: String
    var imageData: Data?
    
    init(id: UUID, title: String, platform: String, date: Date, category: String, imageData: Data? = nil) {
        self.id = id
        self.title = title
        self.platform = platform
        self.date = date
        self.category = category
        self.imageData = imageData
    }
}
