//
//  ContentView.swift
//  TechnicalAssessmentDemo
//
//  Created by Anas Hamad on 2/19/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var loginService : LoginService
    var body: some View {
        if !loginService.authentecated{
            LoginScreen( loginService: LoginService())
        }else{
            HomeScreen()
        }
    }
}


