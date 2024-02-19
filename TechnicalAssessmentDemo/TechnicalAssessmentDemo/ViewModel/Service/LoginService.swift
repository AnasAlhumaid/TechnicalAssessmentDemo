//
//  LoginService.swift
//  TechnicalAssessmentDemo
//
//  Created by Anas Hamad on 2/19/24.
//

import Foundation
import SwiftUI
class LoginService:ObservableObject{
    
    @AppStorage("AUTH") var authentecated = false
    @KeyChain(key: "stored_password", account: "Login") var storedPassword
    @KeyChain(key: "stored_username", account: "Login") var storedUsername
    
    func Login(email:String,password:String){
        storedPassword = password.data(using: .utf8)
        storedUsername = email.data(using: .utf8)
        authentecated.toggle()
    }
}
