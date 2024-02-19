//
//  HomeScreen.swift
//  TechnicalAssessmentDemo
//
//  Created by Anas Hamad on 2/19/24.
//

import SwiftUI

struct HomeScreen: View {
    @State var chatMessage = ""
    @State var massage: [MassagesModel]?
    @State var isConnected = true
    @State var showAlert = false
    @KeyChain(key: "stored_username", account: "Login") var storedUsername
    
 
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    HStack{
                        HStack{
                            Text("Hello,")
                                .font(.title2)
                                .foregroundStyle(.white)
                            if let storedUsername = storedUsername{
                                Text(String(data: storedUsername , encoding: .utf8) ?? "")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                            }
                            
                            
                        }
                        .padding()
                        Spacer()
                        NavigationLink {
                            UserListScreen(viewModel: GetUsers())
                                .navigationBarBackButtonHidden()
                        } label: {
                            Text("User List")
                                .foregroundStyle(Color("ThemeColor"))
                                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 40)
                                .background(.white)
                                .cornerRadius(10)
                        }
                        .padding()
                    }
                    .frame(width: size.width,height: size.height/10)
                    
                    .background(Color("ThemeColor"))
                    
                    
                    Spacer()
                    
                    if ((massage?.isEmpty) != nil){
                        
                        //                    here is Display massages
                        
                    }else{
                        
                        GeometryReader { geometry in
                            ScrollView {
                                VStack(alignment: .center) {
                                    Spacer()
                                    if isConnected{
                                        Text("Connected to WebSocket")
                                            .foregroundStyle(.gray)
                                        Button(action: {
                                            isConnected.toggle()
                                        }) {
                                            Text("Disconnect")
                                                .foregroundColor(.white)
                                                .frame(width: 120, height: 40)
                                                .background(Color("ThemeColor"))
                                                .cornerRadius(10)
                                            
                                        }
                                    }else{
                                        Text("Connect to WebSocket")
                                            .foregroundStyle(.gray)
                                        Button(action: {
                                            isConnected.toggle()
                                        }) {
                                            Text("Connect")
                                                .foregroundColor(.white)
                                                .frame(width: 120, height: 40)
                                                .background(Color("ThemeColor"))
                                                .cornerRadius(10)
                                            
                                        }
                                    }
                                   
                                    Spacer()
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .frame(width: geometry.size.width, height: geometry.size.height)
                            }
                            .frame(width: geometry.size.width, height: geometry.size.height)
                        }
                    }
                    HStack{
                        TextField("Enter Meesage", text: $chatMessage)
                        Button(action: {
                            showAlert.toggle()
                        }, label: {
                            Image(systemName: "paperplane")
                                .foregroundStyle(Color("ThemeColor"))
                        })
                        .disabled(chatMessage.isEmpty ?  true : false )
                        
                    }
                    .padding()
                    .frame(width: size.width - 40)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray,lineWidth: 0.5)
                        
                        
                    )
                    
                    
                }
                
                .alert(isPresented: $showAlert) {
                           Alert(title: Text("Message Sent!"), message: Text("\(chatMessage)"), dismissButton: .default(Text("Dismiss")))
                       }
            }
        }
    }
}

#Preview {
    HomeScreen()
}
