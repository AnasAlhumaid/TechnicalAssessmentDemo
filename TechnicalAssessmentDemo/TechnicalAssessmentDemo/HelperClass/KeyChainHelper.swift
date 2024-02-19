//
//  KeyChainHelper.swift
//  TechnicalAssessmentDemo
//
//  Created by Anas Hamad on 2/19/24.
//

import Foundation

class KeyChainHelper{
    
    static let standerd = KeyChainHelper()
    
    func savePasswordToKeychain(key: String, account: String,data:Data) {
       
            let query = [
                kSecClass : kSecClassGenericPassword,
                kSecAttrService : key,
                kSecValueData :  data,
                kSecAttrAccount : account
                
            ] as CFDictionary

            // Delete existing password
         SecItemDelete(query)

            // Add new password
            let status = SecItemAdd(query as CFDictionary, nil)
            
            
            if status != errSecSuccess {
                print("Error saving password to Keychain")
            }else {
                print("Success Stored")
            }
            if status == errSecDuplicateItem {
                let updateQuery: [String: Any] = [
                    kSecClass as String: kSecClassGenericPassword,
                    kSecAttrAccount as String: account,
                   
                    
                ]
                let updateAtrr = [kSecValueData : data] as CFDictionary
                
                SecItemUpdate(updateQuery as CFDictionary, updateAtrr)
            }
        
    }
    
    func retrievePasswordFromKeychain(account: String,key:String) -> Data? {
        
             let query = [
                 kSecClass : kSecClassGenericPassword,
                 kSecAttrService : key,
                 kSecAttrAccount : account,
                 kSecReturnData : true
                 
                 
             ] as CFDictionary

        var retrievedData: AnyObject?
        SecItemCopyMatching(query , &retrievedData)

        return retrievedData as? Data
    }
    
    func deletePasswordFromKeychain (account: String,key:String){
        let query = [
            kSecClass : kSecClassGenericPassword,
            kSecAttrService : key,
            kSecAttrAccount : account,

        ] as CFDictionary
        SecItemDelete(query as CFDictionary)
    }
}
