//
//  AnyAppAlert.swift
//  MyConcert
//
//  Created by Lesley Koopmans on 08/12/2025.
//
import SwiftUI
import Foundation

struct AnyAppAlert: Sendable {
    var title: String
    var subtitle: String?
    var buttons: @Sendable () -> AnyView
    
    init(
        title: String,
        subtitle: String? = nil,
        buttons: (@Sendable () -> AnyView)? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.buttons = buttons ?? {
            AnyView(
                Button("OK") {
                    
                }
            )
        }
    }
    
    init(error: Error) {
        self.init(title: "Error", subtitle: error.localizedDescription, buttons: nil)
    }
}

extension View {
    func showCustomAlert(alert: Binding<AnyAppAlert?>) -> some View {
        self
            .alert(alert.wrappedValue?.title ?? "", isPresented: Binding(ifNotNil: alert)) {
                alert.wrappedValue?.buttons()
            } message: {
                if let subtitle = alert.wrappedValue?.subtitle {
                    Text(subtitle)
                }
            }
    }
}
