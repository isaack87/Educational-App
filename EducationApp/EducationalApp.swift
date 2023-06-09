//
//  EducationAppApp.swift
//  EducationApp
//
//  Created by Isaac Kim on 3/27/23.
//

import SwiftUI

@main
struct EducationalApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
