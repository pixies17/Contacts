//
//  AddContactVC.swift
//  Contacts
//
//  Created by 123 on 11.11.2019.
//

import UIKit

class AddContactVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let cells: [AddingContactCellType] = [.name, .secondaryName, .phone]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    private func configureTableView() {
          tableView.delegate = self
          tableView.dataSource = self
          tableView.tableFooterView = .init(frame: .zero)
    }
    
    @IBAction func addContactTapped(_ sender: Any) {
        guard
            let nameIndex = cells.firstIndex(of: .name),
            let secondaryNameIndex = cells.firstIndex(of: .secondaryName),
            let phoneIndex = cells.firstIndex(of: .phone),
            let nameCell = tableView.cellForRow(at: IndexPath(row: nameIndex, section: 0)) as? AddingContactCell,
            let secondaryNameCell = tableView.cellForRow(at: IndexPath(row: secondaryNameIndex, section: 0)) as? AddingContactCell,
            let phoneCell = tableView.cellForRow(at: IndexPath(row: phoneIndex, section: 0)) as? AddingContactCell,
            let name = nameCell.textField.text
        else { return }
        
        let secondaryName = secondaryNameCell.textField.text ?? ""
        let phone = phoneCell.textField.text ?? ""
        
        let newContact = Contact(name: name, secondaryName: secondaryName, phone: phone)
        ContactsManager.shared.contacts.append(newContact)
        ContactsManager.shared.saveToUD()
        
        navigationController?.popViewController(animated: true)
    }

}

extension AddContactVC: UITableViewDelegate {
    
}

extension AddContactVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "addingContactCell") as? AddingContactCell else {
            return UITableViewCell()
        }
        
        if let type = AddingContactCellType.init(rawValue: indexPath.row) {
            cell.configureWith(type: type)
        }
        
        return cell
    }
    
    
}

