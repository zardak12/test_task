//
//  NetworkManager.swift
//  Test_Task
//
//  Created by Марк Шнейдерман on 09.02.2021.
//

import Foundation
import UIKit

class NetworkManager {
    let session = URLSession.shared
    static let sharedData = NetworkManager()
    
    func obtainPost(completion:@escaping([Post])->Void){
        guard let url =  URL(string: "https://jsonplaceholder.typicode.com/photos") else {return}
        session.dataTask(with: url) {(data, responce, error) in
            if error == nil,let parseData =  data{
                guard let post = try? JSONDecoder().decode([Post].self, from: parseData) else {return }
                DispatchQueue.main.async {
                    completion(post) 
                }
            }
            else {
                print("Error:\(error?.localizedDescription)")
            }
        }.resume()
    }
    
   
}
