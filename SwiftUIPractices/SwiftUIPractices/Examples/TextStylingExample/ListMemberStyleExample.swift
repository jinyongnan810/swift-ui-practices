//
//  MeasurementsExample.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/20.
//

import SwiftUI

struct ListMemberStyleExample: View {
    let sesameStreetNames = [
        "Elmo",
        "Big Bird",
        "Cookie Monster",
        "Oscar the Grouch",
        "Abby Cadabby"
    ]

    let even = [0,2,4,6,8,10]

    let length = Measurement(value: 225, unit: UnitLength.centimeters)

    var body: some View {
        VStack(spacing: 30) {
            Text(sesameStreetNames, format: .list(type: .and))
            Text(sesameStreetNames, format: .list(type: .or))
            Text(even, format: .list(memberStyle: .number, type: .and))
            Text(even, format: .list(memberStyle: .percent, type: .and))
            Text(length, format: .measurement(width: .abbreviated))
            Text(length, format: .measurement(width: .wide))
        }.padding()
    }
}

#Preview {
    ListMemberStyleExample()
}
