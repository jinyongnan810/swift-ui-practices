//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth

class ChatViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var messageTextfield: UITextField!

    let messages = [
        Message(sender: "sender1", body: "hi"),
        Message(sender: "sender2", body: "hi too")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        title = "⚡️FlashChat"

        tableView.delegate = self
        tableView.dataSource = self
    }

    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch {
            print("Failed to sign out: \(error.localizedDescription)")
            self.showToast(message: error.localizedDescription)
        }
    }
    @IBAction func sendPressed(_: UIButton) {}
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: K.cellIdentifier,
            for: indexPath
        )

        let message = messages[indexPath.row]

        var config = cell.defaultContentConfiguration()
        config.text = message.body
        config.secondaryText = message.sender
        cell.contentConfiguration = config

        return cell
    }


}

extension ChatViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        print("⭐️ selected row: \(indexPath.row)")
    }
}
