//
//  CertificateRowView.swift
//  CertyApp
//
//  Created by Łukasz Adamczak on 14/10/2025.
//

import SwiftUI

struct CertificatRowView: View {
    let cetificate: Certificate
    
    var body: some View {
        HStack {
            //miniaturka z imageDate jeśli będzie
            if let data = cetificate.imageData, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            } else {
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 50, height: 50)
                    .overlay(Image(systemName: "doc.richtext").font(.title2))
                    .foregroundStyle(.secondary)
            }
            
            VStack(alignment: .leading) {
                Text(cetificate.title)
                    .font(.headline)
                Text("\(cetificate.platform) • \(formattedDate(cetificate.date))")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Text(cetificate.category)
                .font(.caption)
                .padding(6)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .padding(.vertical, 6)
    }
    
    private func formattedDate(_ date: Date) -> String {
        let f = DateFormatter()
        f.dateStyle = .medium
        return f.string(from: date)
    }
}

#Preview {
    CertificatRowView(cetificate: Certificate(id: UUID(), title: "test", platform: "test", date: Date(), category: "test"))
}
