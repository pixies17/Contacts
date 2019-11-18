//
//  AddingContactCell.swift
//  Contacts
//
//  Created by 123 on 11.11.2019.
//

import UIKit

class AddingContactCell: UITableViewCell {
    
    enum ViewType: Int {
        case name
        case secondaryName
        case phone
    }
    
    var type: ViewType = .name

    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
    }
    
    func configureWith(type: ViewType) {
        switch type {
        case .name:
            textField.placeholder = "Имя"
        case .secondaryName:
            textField.placeholder = "Фамилия"
        case .phone:
            textField.placeholder = "Телефон"
            textField.keyboardType = .phonePad
        }
    }
    
}

extension AddingContactCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

