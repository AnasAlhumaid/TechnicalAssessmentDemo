//
//  GetUsers.swift
//  TechnicalAssessmentDemo
//
//  Created by Anas Hamad on 2/19/24.
//

import Foundation
class GetUsers:ObservableObject{
    
    @Published var users: [UsersModel] = []
    @Published var usersData : [DataModel] = []
    @Published var errorMessage = ""
    
    func fetchUsersData( completion: @escaping ([DataModel]) -> Void) {
        let urlString = "https://gorest.co.in/public-api/users" // Replace with your API URL
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Create a URLSession and data task
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                // Handle network-related errors
                switch error {
                case URLError.notConnectedToInternet:
                    print("No internet connection")
                    self.errorMessage = "No internet connection"
                case URLError.timedOut:
                    print("Request timed out")
                    self.errorMessage = "Request timed out"
                default:
                    print("Network request failed: \(error)")
                    self.errorMessage = "Network request failed: \(error)"
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                print("HTTP status code \(httpResponse.statusCode)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response1 = try decoder.decode(UsersModel.self, from: data)
                
                DispatchQueue.main.async {
                  
                    if response1.data != nil {
                        self.usersData = response1.data!
                        completion(response1.data!)
                    }
                   
                }
                
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        task.resume()
    }

    
}
