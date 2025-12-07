//
//  CreateConcertView.swift
//  MyConcert
//
//  Created by Lesley Koopmans on 07/12/2025.
//

import SwiftUI

struct CreateConcertView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Text("Create Concert")
            .onTapGesture {
                dismiss()
            }
    }
}

#Preview {
    CreateConcertView()
}
