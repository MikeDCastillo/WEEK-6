//
//  PersonController.swift
//  SixWeekTest
//
//  Created by Michael Castillo on 3/17/17.
//  Copyright © 2017 Michael Castillo. All rights reserved.
//

import Foundation

struct PersonController {
    
    // MARK: - Get Func
    
    static let baseURL = URL(string: "https://sixweektest.firebaseio.com/")
    
    static func getNamesFromFirebaseDatabase(completion: @escaping ([Person]) -> Void ) {
        
        guard let unwrappedURl = baseURL else { completion([]); return }
        
        let url = unwrappedURl.appendingPathExtension("json")
        
        NetworkController.performRequest(for: url, httpMethod: .get, urlParameters: nil, body: nil) { (data, error) in
            
            if let error = error {
                print(error.localizedDescription)
                completion([])
                return
            }
            
            guard let data = data,
            let jsonDictionary = ( try?JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: [String: Any]],
            let personDictionary = jsonDictionary["name"] as? [String: [String:String]] else {completion([]); return}
            
            let responseData = personDictionary.flatMap({ Person (dictionary: $0.value)})
            
            completion(responseData)
        }
    }
    
    
    // MARK: - Put Func
    
    static func postDataIntoFirebaseDatabase(name: String) {
    
        let name = Person(name: name)
        
        guard let unwrappedURL = baseURL else { return }
        
        let url = unwrappedURL.appendingPathComponent("name").appendingPathComponent(".json")
        
        NetworkController.performRequest(for: url, httpMethod: .post, urlParameters: nil, body: name.jsonData) { (data, error) in
            
            guard let data = data,
                let responseData = String(data: data, encoding: .utf8) else {return}
            
            if let error = error {
                print(error.localizedDescription)
            } else if responseData.contains("error") {
                print("\(error?.localizedDescription)")
            } else {
                print("\(responseData)")
            }
        }
    }
    
    
}
