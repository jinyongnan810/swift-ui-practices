//
//  MessageBrain.swift
//  FlashChat
//
//  Created by Yuunan kin on 2024/12/14.
//

import FirebaseFirestore

protocol MessageBrainDelegate {
    func messagesUpdated()
}

class MessageBrain {
    var db: Firestore

    var messages: [Message] = []

    var delegate: MessageBrainDelegate?

    init() {
        db = Firestore.firestore()
    }

    func startListenForMessageUpdates() {
        db.collection("messages").order(by: "date", descending: false)
            .addSnapshotListener {
                snapshot,
                    error in
                guard let documents = snapshot?.documents else {
                    print("Error fetching document: \(error!)")
                    return
                }
                self.messages = documents.compactMap { docSnapshot in
                    let doc = docSnapshot.data()
                    let sender = doc[K.FStore.senderField] as? String ?? ""
                    let body = doc[K.FStore.bodyField] as? String ?? ""
                    let date = doc[K.FStore.dateField] as? Timestamp ?? Timestamp()
                    return Message(sender: sender, body: body, date: date.dateValue())
                }
                print("⭐️messsages: \(self.messages.count)")
                self.delegate?.messagesUpdated()
            }
    }

    func sendMessage(_ message: Message) {
        db.collection(K.FStore.collectionName).addDocument(data: [
            K.FStore.bodyField: message.body,
            K.FStore.senderField: message.sender,
            K.FStore.dateField: FieldValue.serverTimestamp(),
        ]) { error in
            if let error {
                print("error sending message: \(error.localizedDescription)")
            }
        }
    }
}
