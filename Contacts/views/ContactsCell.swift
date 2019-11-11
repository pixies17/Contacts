//
//  ContactsCell.swift
//  Contacts
//
//  Created by 123 on 11.11.2019.
//

import UIKit

class ContactsCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    func configureWith(contact: Contact) {
        nameLabel.text = contact.secondaryName + " " + contact.name
    }
    
}
