//
//  ListItem.swift
//  TechnicalAssessmentDemo
//
//  Created by Anas Hamad on 2/19/24.
//

import SwiftUI

struct ListItem: View {
    var userList : UserCoreData
   
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(userList.name ?? "" )
                    .fontWeight(.bold)
                    .font(.callout)
                    .foregroundStyle(.black)
                Text(userList.email ?? "" )
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            Spacer()
            HStack{
                
                Text(userList.status ?? "" )
                    .foregroundStyle(userList.status ?? "" == Status.active.rawValue ? .green : .gray)
                Image(systemName: "chevron.right")
                    .foregroundStyle(.gray)
            }
        }
        .frame(width: size.width - 30)
        Divider()
    }
 
}


