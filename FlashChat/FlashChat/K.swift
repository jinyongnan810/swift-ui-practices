enum K {
    static let appName = "⚡️FlashChat"
    static let cellIdentifier = "ReusableMessageCell"
    static let cellNibName = "MessageCell"
    static let registerToChatSegue = "RegisterToChat"
    static let loginToCHatSegue = "LoginToChat"

    enum BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }

    enum FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
