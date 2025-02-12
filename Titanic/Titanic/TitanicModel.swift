//
//  TitanicModel.swift
//  Titanic
//
//  Created by Yuunan kin on 2025/02/12.
//

import Foundation

enum Gender: String, CaseIterable {
    case male = "Male"
    case female = "Female"
}

enum Port: String, CaseIterable {
    case cherbourg = "Cherbourg"
    case queenstown = "Queenstown"
    case southampton = "Southampton"
}

enum PassengerClass: String, CaseIterable {
    case firstClass = "First Class"
    case secondClass = "Second Class"
    case thirdClass = "Third Class"
}

struct TitanicModel: Identifiable {
    let id: UUID = .init()
    var passengerClass: PassengerClass
    var sex: Gender
    var age: Double
    var siblings: Double
    var parentsChildren: Double
    var fare: Double
    var port: Port

    var Pclass: Int64 {
        switch passengerClass {
        case .firstClass:
            1
        case .secondClass:
            2
        case .thirdClass:
            3
        }
    }

    var Sex: String {
        switch sex {
        case .male:
            "male"
        case .female:
            "female"
        }
    }

    var Embarked: String {
        switch port {
        case .cherbourg:
            "C"
        case .queenstown:
            "Q"
        case .southampton:
            "S"
        }
    }
}
