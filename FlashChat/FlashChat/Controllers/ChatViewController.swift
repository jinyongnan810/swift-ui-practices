//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import FirebaseAuth
import UIKit

class ChatViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var messageTextfield: UITextField!

    let messageBrain = MessageBrain()

    override func viewDidLoad() {
        super.viewDidLoad()
        messageBrain.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView
            .register(
                UINib(nibName: K.cellNibName, bundle: nil),
                forCellReuseIdentifier: K.cellIdentifier
            )

        navigationItem.hidesBackButton = true
        title = K.appName

        messageBrain.startListenForMessageUpdates()
    }

    @IBAction func logoutPressed(_: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch {
            print("Failed to sign out: \(error.localizedDescription)")
            showToast(message: error.localizedDescription)
        }
    }

    @IBAction func sendPressed(_: UIButton) {
        guard let text = messageTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines), let email = Auth.auth().currentUser?.email else {
            return
        }
        let message = Message(sender: email, body: text, date: Date.now)
        messageBrain.sendMessage(message)
        messageTextfield.text = ""
    }
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        messageBrain.messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: K.cellIdentifier,
            for: indexPath
        ) as! MessageCell

        let message = messageBrain.messages[indexPath.row]
        cell.label.text = message.body

        return cell
    }
}

extension ChatViewController: UITableViewDelegate {
    func tableView(
        _: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        print("⭐️ selected row: \(indexPath.row)")
    }
}

extension ChatViewController: MessageBrainDelegate {
    func messagesUpdated() {
        tableView.reloadData()
    }
}
