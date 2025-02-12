//
//  PredictView.swift
//  Titanic
//
//  Created by Yuunan kin on 2025/02/12.
//

import CoreML
import SwiftUI

struct PredictView: View {
    @State private var userInfo = TitanicModel(
        passengerClass: .firstClass,
        sex: .female,
        age: 20,
        siblings: 1,
        parentsChildren: 2,
        fare: 100,
        port: .cherbourg
    )

    @State private var showErrorAlert: Bool = false
    @State private var showPredictionAlert: Bool = false
    @State private var prediction: Double?

    var body: some View {
        NavigationStack {
            List {
                Section("Personal") {
                    VStack {
                        ItemTitleView(title: "Gender")
                        Picker(selection: $userInfo.sex) {
                            ForEach(Gender.allCases, id: \.self) { gender in
                                Text(gender.rawValue)
                            }
                        } label: {
                            Text("Gender")
                        }.pickerStyle(SegmentedPickerStyle())
                    }

                    VStack {
                        ItemTitleView(title: "Age: \(userInfo.age)")
                        Slider(value: $userInfo.age, in: 0 ... 100, step: 0.5)
                    }
                }

                Section("Relationship") {
                    VStack {
                        ItemTitleView(title: "Siblings: \(userInfo.siblings.formatted())")
                        Slider(value: $userInfo.siblings, in: 0 ... 10, step: 1)
                    }
                    VStack {
                        ItemTitleView(title: "Parents or Children: \(userInfo.parentsChildren.formatted())")
                        Slider(value: $userInfo.parentsChildren, in: 0 ... 10, step: 1)
                    }
                }

                Section("Boarding Info") {
                    VStack {
                        ItemTitleView(title: "Passenger Class")
                        Picker(selection: $userInfo.passengerClass) {
                            ForEach(PassengerClass.allCases, id: \.self) {
                                Text("\($0.rawValue)")
                            }
                        } label: {
                            Text("Passenger Class")
                        }.pickerStyle(SegmentedPickerStyle())
                    }

                    VStack {
                        ItemTitleView(title: "Port")
                        Picker(selection: $userInfo.port) {
                            ForEach(Port.allCases, id: \.self) {
                                Text("\($0.rawValue)")
                            }
                        } label: {
                            Text("Port")
                        }.pickerStyle(SegmentedPickerStyle())
                    }

                    VStack {
                        ItemTitleView(title: "Fare: \(format(userInfo.fare))")
                        Slider(value: $userInfo.fare, in: 0 ... 1000)
                    }
                }
            }
            .navigationTitle("Titanic Prediction")
            .alert("Error", isPresented: $showErrorAlert) {
                VStack {
                    Text("Failed to load model.")
                    Button("OK", role: .cancel) {}
                }
            }
            .alert("Prediction", isPresented: $showPredictionAlert) {
                VStack {
                    if let prediction {
                        Text("Prediction: \(prediction * 100)%")
                    }
                    Button("OK", role: .cancel) {}
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Predict") {
                        guard let model = try? TitanicRegressionModel1(configuration: .init()) else {
                            showErrorAlert = true
                            return
                        }
                        prediction = nil
                        let input: TitanicRegressionModel1Input = .init(
                            Pclass: userInfo.Pclass,
                            Sex: userInfo.Sex,
                            Age: userInfo.age,
                            SibSp: Int64(userInfo.siblings),
                            Parch: Int64(userInfo.parentsChildren),
                            Fare: userInfo.fare,
                            Embarked: userInfo.Embarked
                        )
                        let result = try? model.prediction(
                            input: input
                        )
                        print("⭐️ result: \(String(describing: result?.Survived))")
                        prediction = result?.Survived
                        showPredictionAlert = true
                    }
                }
            }
        }
    }

    func format(_ val: Double?) -> String {
        guard let val else { return "NaN" }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        return formatter.string(from: NSNumber(value: val)) ?? "NaN"
    }
}

struct ItemTitleView: View {
    var title: String
    var body: some View {
        HStack {
            Text(title)
            Spacer()
        }
    }
}

#Preview {
    PredictView()
}
