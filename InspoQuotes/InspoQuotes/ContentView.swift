//
//  ContentView.swift
//  InspoQuotes
//
//  Created by Yuunan kin on 2024/12/31.
//

import SwiftUI
import StoreKit

struct ContentView: View {
    @State var showPremiumQuotes = false
    let basicQuotes = [
        "Our greatest glory is not in never falling, but in rising every time we fall. — Confucius",
        "All our dreams can come true, if we have the courage to pursue them. – Walt Disney",
        "It does not matter how slowly you go as long as you do not stop. – Confucius",
        "Everything you’ve ever wanted is on the other side of fear. — George Addair",
        "Success is not final, failure is not fatal: it is the courage to continue that counts. – Winston Churchill",
        "Hardships often prepare ordinary people for an extraordinary destiny. – C.S. Lewis"
    ]

    let premiumQuotes = [
        "Believe in yourself. You are braver than you think, more talented than you know, and capable of more than you imagine. ― Roy T. Bennett",
        "I learned that courage was not the absence of fear, but the triumph over it. The brave man is not he who does not feel afraid, but he who conquers that fear. – Nelson Mandela",
        "There is only one thing that makes a dream impossible to achieve: the fear of failure. ― Paulo Coelho",
        "It’s not whether you get knocked down. It’s whether you get up. – Vince Lombardi",
        "Your true success in life begins only when you make the commitment to become excellent at what you do. — Brian Tracy",
        "Believe in yourself, take on your challenges, dig deep within yourself to conquer fears. Never let anyone bring you down. You got to keep going. – Chantal Sutherland"
    ]

    var displayedQuotes: [Quote] {
        var quotes: [String] = []
        if showPremiumQuotes {
            quotes = basicQuotes + premiumQuotes
        } else {
            quotes = basicQuotes
        }
        return quotes.map { Quote(id: UUID().uuidString, quote: $0)}
    }

    let productId = "com.kinn.InspoQuotes.PremiumQuotes"
    func buyPremiumQuotes() {
        if !AppStore.canMakePayments {
            print("⭐️ User cannot make payment")
            return
        }

        Task {
            do {
                let product = try await Product.products(for: [productId]).first!
                let result = try await product.purchase()

                switch result {
                    case .success(let verification):
                        switch verification {
                            case .verified(let transaction):
                                // Handle successful purchase
                                print("⭐️Purchase successful: \(transaction)")
                                await transaction.finish()
                            case .unverified(_, let error):
                                // Handle failed verification
                                print("Purchase verification failed: \(error)")
                        }
                    case .userCancelled:
                        // Handle user cancellation
                        print("Purchase cancelled by user")
                    case .pending:
                        // Handle pending purchase
                        print("Purchase is pending")
                    @unknown default:
                        // Handle unknown case
                        print("Unknown purchase result")
                }
            } catch {
                // Handle error
                print("Purchase failed: \(error)")
            }
        }

    }

    func checkPurchaseStatus() {
        Task {
            for await result in Transaction.currentEntitlements {
                if case .verified(let transaction) = result {
                    if transaction.productID == productId {
                        print("⭐️already purchased")
                        showPremiumQuotes = true
                        break
                    }
                }
            }
        }
    }

    func listenForTransactionUpdates() {
        Task {
            for await result in Transaction.updates {
                if case .verified(let transaction) = result {
                    if transaction.productID == productId {
                        print("⭐️transaction verified")
                        showPremiumQuotes = true
                        await transaction.finish()
                    }
                }
            }
        }
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(displayedQuotes) { quote in
                    Text(quote.quote)
                }
            }
            .navigationTitle("Inspo Quotes")
            .navigationBarItems(trailing: Button(action: {
                buyPremiumQuotes()
            }) {
                Image(systemName: "plus")
            })
            .onAppear {
                checkPurchaseStatus()
                listenForTransactionUpdates()
            }
        }

    }
}

struct Quote: Identifiable {
    var id: String
    var quote: String
}


#Preview {
    ContentView()
}

