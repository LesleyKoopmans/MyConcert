//
//  SectionHeaderView.swift
//  MyConcert
//
//  Created by Lesley Koopmans on 08/12/2025.
//

import SwiftUI

struct SectionHeaderView: View {
    
    var icon: String = "photo"
    var title: String = "Description"
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
            Text(title.uppercased())
        }
        .font(.footnote)
        .foregroundStyle(.secondary)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    SectionHeaderView()
}
