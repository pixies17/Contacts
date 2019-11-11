//
//  ContactsManager.swift
//  Contacts
//
//  Created by 123 on 11.11.2019.
//

import Foundation

class ContactsManager {
    
    static let shared = ContactsManager()
    
    var contacts: [Contact] = []
    
    init() {
        getValuesFromUD()
    }
    
    func getValuesFromUD() {
        guard let data = UserDefaults.standard.data(forKey: "contacts") else { return }
        let decoder = JSONDecoder()
        if let savedContacts = try? decoder.decode(Array.self, from: data) as [Contact] {
            contacts = savedContacts
        }
    }
    
    func saveToUD() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(contacts)
            UserDefaults.standard.set(data, forKey: "contacts")
        } catch {
            print("contacts saving error")
        }
    }
    
}
    
