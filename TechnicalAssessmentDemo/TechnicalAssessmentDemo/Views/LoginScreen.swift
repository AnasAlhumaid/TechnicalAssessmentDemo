//
//  LoginScreen.swift
//  TechnicalAssessmentDemo
//
//  Created by Anas Hamad on 2/19/24.
//

import SwiftUI
import Security

var size = UIScreen.main.bounds.size

struct LoginScreen: View {
    
    @State var userName = ""
    @State var passWord = ""
    @State var showAlert = false
    @ObservedObject var loginService : LoginService

    
    
   
    
    
    var body: some View {
        ZStack{
            Color("BackGraoundColor")
                .ignoresSafeArea()
            VStack{
                VStack{
                    Text("Hello,")
                        .fontWeight(.medium)
                        .font(.title)
                        .foregroundStyle(Color("ThemeColor"))
                    
                    TextField("Username", text: $userName)
                        .padding(10)
                        .frame(height: 40)
                        .background(.white)
                        .cornerRadius(10)
                        .padding(.vertical)
                    
                    SecureField("Password", text: $passWord)
                        .padding(10)
                        .frame(height: 40)
                        .background(.white)
                        .cornerRadius(10)
                     
                    
                    Button(action: {
                        if userName.isEmpty || passWord.isEmpty{
                            showAlert.toggle()
                        }else {
                            loginService.Login(email: userName, password: passWord)
                      
                    
                        }
                        
                    }, label: {
                        Text("Login")
                            .foregroundStyle(.white)
                            .frame(width: 120,height: 40)
                            .background(Color("ThemeColor"))
                            .cornerRadius(10)
                            .padding()
                    })
                    
                }
                .frame(width: size.width - 100)
                Spacer()
                    .frame(height: size.height / 3.5 )
            }
            
        }
     
        .alert(isPresented: $showAlert) {
                   Alert(title: Text("Empety Field!"), message: Text("Username or Password is empety"), dismissButton: .default(Text("Dismiss")))
               }
    }
    
  


}


