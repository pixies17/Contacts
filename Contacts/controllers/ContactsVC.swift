//
//  ContactsVC.swift
//  Contacts
//
//  Created by 123 on 11.11.2019.
//

import UIKit

class ContactsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var contacts: [Contact] = []
    var editMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateContacts()
        tableView.reloadData()
        showAlertIfNeeded()
    }
    
    func updateContacts() {
        contacts = ContactsManager.shared.contacts.sorted(by: {$0.secondaryName != $1.secondaryName ? ($0.secondaryName < $1.secondaryName) : ($0.name < $1.name)})
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = .init(frame: .zero)
    }
    
    private func showAlertIfNeeded() {
        if contacts.isEmpty {
            let alert = UIAlertController(title: nil, message: "Для добавления контакта нажмите на кнопку сверху", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        editMode.toggle()
        tableView.setEditing(editMode, animated: true)
        
        navigationItem.leftBarButtonItem?.title = editMode ? "Save" : "Edit"
    }
}

extension ContactsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let contact = contacts[indexPath.row]
        if let url = URL.init(string: "tel://\(contact.phone)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete,
            let index = ContactsManager.shared.contacts.firstIndex(of: contacts[indexPath.row])
        else { return }
        ContactsManager.shared.contacts.remove(at: index)
        ContactsManager.shared.saveToUD()
        updateContacts()
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

extension ContactsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "contactsCell") as? ContactsCell else {
            return UITableViewCell()
        }
        
        cell.configureWith(contact: contacts[indexPath.row])
        return cell
    }
    
}
