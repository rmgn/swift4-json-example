//
//  APIManager.swift
//  swiftlearning
//
//  Created by Ranjith Karuvadiyil on 31/01/19.
//  Copyright © 2019 mistybits. All rights reserved.
//

import Foundation
import SystemConfiguration

class APIManager {  
    let stubDataURL = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    
    func getDaraFromUrl(completion: @escaping (_ swifter: Swifter?, _ error: Error?) -> Void) {
        getJSONFromURL(urlString: stubDataURL) { (data, error) in
            guard let data = data, error == nil else {
                print("Failed to get data")
                return completion(nil, error)
            }
            self.createRowObjectWith(json: data, completion: { (rows, error) in
                if let error = error {
                    print("Failed to convert data")
                    return completion(nil, error)
                }
                return completion(rows, nil)
            })
        }
    }
    
}

extension APIManager {
    private func getJSONFromURL(urlString: String, completion: @escaping (_ data: Data?, _ error: Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Error: Cannot create URL from string")
            return
        }
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            guard error == nil else {
                print("Error calling api")
                return completion(nil, error)
            }
            guard let responseData = data else {
                print("Data is nil")
                return completion(nil, error)
            }
            
            let convertedString = String(data: responseData, encoding: String.Encoding.isoLatin1)!
//            print("string \(convertedString)")
            
            let newdata = Data(convertedString.utf8)

            completion(newdata, nil)
        }
        task.resume()
    }
    
    private func createRowObjectWith(json: Data, completion: @escaping (_ data: Swifter?, _ error: Error?) -> Void) {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let swifter = try decoder.decode(Swifter.self, from: json)
            return completion(swifter, nil)
        } catch let error {
            print("Error creating current swifter from JSON because: \(error.localizedDescription)")
            return completion(nil, error)
        }
    }
}
