//
//  GreetingsTip.swift
//  Greetings
//
//  Created by Yuunan kin on 2025/01/13.
//
import Foundation
import TipKit

struct GreetingsTip: Tip {
    var title: Text {
        Text("This is Greetings")
    }

    var message: Text? {
        Text("Text will be generated automatically.")
    }

    var asset: Image? {
        Image(systemName: "star")
    }
}
