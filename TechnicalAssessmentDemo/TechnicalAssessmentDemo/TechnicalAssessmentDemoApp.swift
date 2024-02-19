//
//  TechnicalAssessmentDemoApp.swift
//  TechnicalAssessmentDemo
//
//  Created by Anas Hamad on 2/19/24.
//

import SwiftUI

@main
struct TechnicalAssessmentDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(loginService: LoginService())
                .environment(\.managedObjectContext, CoreDataProvider.shared.viewContext)
        }
    }
}
