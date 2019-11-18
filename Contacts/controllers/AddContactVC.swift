//
//  AddContactVC.swift
//  Contacts
//
//  Created by 123 on 11.11.2019.
//

import UIKit

class AddContactVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let cells: [AddingContactCell.ViewType] = [.name, .secondaryName, .phone]
    
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
        
        Spinner.shared.show(in: view)
        API.createContact(name: name, secondaryName: secondaryName, phone: phone) { (success) in
            Spinner.shared.hide()
            if success {
                self.navigationController?.popViewController(animated: true)
            } else {
                let alert = UIAlertController(title: nil, message: "При создании контакта произошла ошибка", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
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
        
        if let type = AddingContactCell.ViewType(rawValue: indexPath.row) {
            cell.configureWith(type: type)
        }
        
        return cell
    }
    
    
}

