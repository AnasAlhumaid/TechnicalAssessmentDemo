//
//  UserListScreen.swift
//  TechnicalAssessmentDemo
//
//  Created by Anas Hamad on 2/19/24.
//

import SwiftUI

struct UserListScreen: View {
    @State var showAlertError = false
    @State var showAlertInternet = false
    @State private var networkMonitor = NetworkMonitor()
    
    @ObservedObject var viewModel : GetUsers
    @Environment(\.dismiss) var dissmes
    
    @FetchRequest(fetchRequest: UserCoreData.all)
    var userResults : FetchedResults<UserCoreData>
    @State var users : [UserCoreData] = []
    @Environment(\.managedObjectContext) private var viewContext
    
    
    var body: some View {
        ZStack{
            VStack{
                
                HStack {
                    Button {
                        dissmes()
                        deleteUsers()
                    } label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .frame(width: 10, height: 20)
                            .foregroundColor(.white)
                    }
                    .padding(.leading) // Add padding to the leading edge of the button
                    
                    Spacer()
                    
                    Text("Users")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    
                    Spacer()
                        .frame(width: size.width/2.25)
                }
                .frame(width: size.width,height: size.height / 5 - 120 )
                .background(Color("ThemeColor"))
                ScrollView{
                    VStack{
                        ForEach(users, id: \.self) { item in
                            if item.name != nil {
                                ListItem(userList: item )
                            }
                        }
                        
                    }
                    .padding(.vertical)
                    
                }
                
                Spacer()
            }
            .alert(isPresented: $showAlertError) {
                Alert(title: Text("Loading Field!"), message: Text(viewModel.errorMessage))
            }
            .alert(isPresented: $showAlertInternet) {
                Alert(title: Text("No Internet Connection"), message: Text("Please check your connection and try again."))
            }
            
        }
        .onAppear{
            if networkMonitor.isConnected {
                viewModel.fetchUsersData { user in
                    
                    for user in user{
                        
                        saveUser(name: user.name,
                                 gender: user.gender.rawValue,
                                 id: Double(user.id),
                                 email: user.email,
                                 status: user.status.rawValue)
                        
                        
                    }
                    users.removeAll()
                    users.append(contentsOf: userResults)
                    
                }
                
            }else{
                showAlertInternet.toggle()
            }
        }
    }
    
    
    func saveUser(name :String, gender:String,id:Double,email:String,status:String){
        let user = UserCoreData(context: viewContext)
        
        user.name = name
        user.gender = gender
        user.id = id
        user.email = email
        user.status = status
    
        
        do {
           try user.save()
        }catch{
            print(error)
        }
       
        
    }
    func deleteUsers(){
        let user = UserCoreData(context: viewContext)
        do {
           try user.deleteAllData()
        }catch{
            print(error)
        }
    }
}


