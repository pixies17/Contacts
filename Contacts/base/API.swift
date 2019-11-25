//
//  API.swift
//  Contacts
//
//  Created by 123 on 18.11.2019.
//

import Foundation

typealias JSON = [String : Any]

enum API {
    
    static var identifier: String { "pixies" }
    static var baseURL: String {
        "https://ios-napoleonit.firebaseio.com/data/\(identifier)/"
    }
    static var storageName: String { "contacts" }
    
    static func loadContacts(completion: @escaping ([Contact]) -> Void) {
        guard let url = URL(string: baseURL + "\(storageName).json") else { return }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard
                let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? JSON
            else {
                DispatchQueue.main.async {
                    completion([])
                }
                return
            }
            
            var contacts = [Contact]()
            
            json.forEach {
                guard let value = $0.value as? JSON else { return }
                contacts.append(Contact(id: $0.key, data: value))
            }
            
            contacts.sort(by: {$0.secondaryName != $1.secondaryName ? ($0.secondaryName < $1.secondaryName) : ($0.name < $1.name)})
            
            DispatchQueue.main.async {
                completion(contacts)
            }
        }
        task.resume()
    }
    
    static func createContact(name: String, secondaryName: String, phone: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: baseURL + "\(storageName).json") else { return }
        var request = URLRequest(url: url)
        
        let params = [
            "name": name,
            "secondaryName": secondaryName,
            "phone": phone
        ]
        
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params)
        
        let task = URLSession.shared.dataTask(with: request) { (_, _, error) in
            DispatchQueue.main.async {
                completion(error == nil)
            }
        }
        task.resume()
        
    }
    
    static func deleteContact(id: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: baseURL + "\(storageName)/\(id).json/") else { return }
      
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: request) { (_, _, error) in
            DispatchQueue.main.async {
                completion(error == nil)
            }
        }
        task.resume()
    }
    
}
