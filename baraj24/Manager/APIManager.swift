//
//  APIManager.swift
//  baraj24
//
//  Created by Emir AKSU on 23.11.2024.
//

import Foundation



class APIManager {
    static let shared = APIManager()
    
    private init() {}
    
     func takeDams(city: String, completion: @escaping(Result<AllDams, Error>)->Void){
        let url = URL(string: "https://baraj24api.emiraksu.net/currentDams?city=\(city)")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else { print("Data yok")
                return }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            do {
                var decodedData = try decoder.decode(AllDams.self, from: data)
                
       
               completion(.success(decodedData))
            }
            
            catch{
                print("parse error")
            }
            
        }
        task.resume()
     
        }
}
