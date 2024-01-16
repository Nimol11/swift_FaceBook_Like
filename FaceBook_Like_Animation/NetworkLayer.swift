//
//  NetworkLayer.swift
//  FaceBook_Like_Animation
//
//  Created by Nimol on 16/1/24.
//

import Foundation
class NetworkLayer {
    
    static let share = NetworkLayer()
    
    func fetchData<T: Codable> (url: String, completion: @escaping(T)-> Void ) {
        guard let url = URL(string: url) else {
            print("URL Invalid..?")
            return
        }
        URLSession.shared.dataTask(with: url) { data , urlResponse, error in
            if  error == nil,
                let data = data,
               let result = try? JSONDecoder().decode(T.self, from: data){
                completion(result)
            }
           
        }.resume()
    }
}

struct ProductModel: Codable {
    let id: Int?
    let title: String?
    let price: Int?
    let description: String?
    let images: [String]?
    
}
