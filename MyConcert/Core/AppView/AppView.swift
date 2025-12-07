//
//  AppView.swift
//  MyConcert
//
//  Created by Lesley Koopmans on 07/12/2025.
//

import SwiftUI

struct AppView: View {
    
    @AppStorage("showTabbarView") var showTabBar: Bool = false
    
    var body: some View {
        AppViewBuilder(
            showTabBar: showTabBar,
            tabbarView: {
                ZStack {
                    Color.red.ignoresSafeArea()
                    Text("Tabbar")
                }
            },
            onboardingView: {
                ZStack {
                    Color.blue.ignoresSafeArea()
                    Text("Onboarding")
                }
            }
        )
    }
}

#Preview("Appview - Tabbar") {
    AppView(showTabBar: true)
}

#Preview("Appview - Onboarding") {
    AppView(showTabBar: false)
}
