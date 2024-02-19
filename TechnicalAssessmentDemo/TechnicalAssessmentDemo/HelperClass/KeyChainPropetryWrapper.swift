//
//  KeyChainPropetryWrapper.swift
//  TechnicalAssessmentDemo
//
//  Created by Anas Hamad on 2/19/24.
//

import Foundation
import SwiftUI

@propertyWrapper
struct KeyChain: DynamicProperty{
   
    @State var data: Data?
    
    var wrappedValue:Data?{
        get{data
            
            
        }
        set{
            
            guard let newData  = newValue else{
                data = nil
                KeyChainHelper.standerd.deletePasswordFromKeychain(account: account, key: key)
                return
            }
            KeyChainHelper.standerd.savePasswordToKeychain(key: key, account: account, data: newData)
        }
    }
    
    var key : String
    var account : String
    
    init( key: String, account: String) {
       
        self.key = key
        self.account = account
        _data = State(wrappedValue:KeyChainHelper.standerd.retrievePasswordFromKeychain(account: account, key: key))
    }
}
