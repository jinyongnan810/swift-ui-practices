//
//  ContentView.swift
//  ActivityTracker
//
//  Created by Yuunan kin on 2025/02/05.
//

import Charts
import SwiftData
import SwiftUI

struct ContentView: View {
    @Query(sort: \Activity.name, order: .forward)
    var activities: [Activity]
    @Environment(\.modelContext) private var context

    @State private var selectedActivity: Activity?
    @State private var selectedHoursPerDay: Double = 0
    @State private var selectedName: String = ""

    @State private var selectCount: Int?

    @State private var showAddSheet: Bool = false

    var totalHours: Double {
        activities.reduce(0) { $0 + $1.hoursPerDay }
    }

    var remainingHours: Double {
        24 - totalHours
    }

    var maxHoursOfSelectedActivity: Double {
        remainingHours + selectedHoursPerDay
    }

    var body: some View {
        NavigationStack {
            VStack {
                if activities.isEmpty {
                    ContentUnavailableView("Add an Activity", systemImage: "list.dash")
                } else {
                    Chart {
                        ForEach(
                            activities,
                            id: \.id
                        ) { activity in
                            SectorMark(
                                angle:
                                .value(
                                    "Activity",
                                    activity.hoursPerDay
                                ),
                                innerRadius:
                                .ratio(
                                    0.6
                                ),
                                outerRadius:
                                .ratio(
                                    selectedActivity?.id == activity.id ? 1.25 : 0.95
                                ),
                                angularInset: 1
                            )
                            .cornerRadius(
                                12
                            )
                            .foregroundStyle(
                                .blue
                            )
                        }
                    }.chartAngleSelection(value: $selectCount)
                }

                List {
                    ForEach(activities) { activity in
                        ActivityItem(activity: activity)
                            .listRowBackground(selectedActivity?.name == activity.name ? Color.blue.opacity(0.1) : Color.clear)
                            .onTapGesture {
                                withAnimation {
                                    if selectedActivity == activity {
                                        selectedActivity = nil
                                        selectedHoursPerDay = 0
                                        selectedName = ""
                                        return
                                    }

                                    selectedActivity = activity
                                    selectedHoursPerDay = activity.hoursPerDay
                                    selectedName = activity.name
                                }
                            }
                    }
                    .onDelete(perform: removeActivity)
                }

                .listStyle(.plain)
                .scrollIndicators(.hidden)

                if let selectedActivity {
                    TextField("Edit activity name", text: $selectedName)
                        .padding()
                        .background(.blue.gradient.opacity(0.2))
                        .clipShape(.rect(cornerRadius: 10))
                        .shadow(radius: 2)
                    Slider(
                        value: $selectedHoursPerDay,
                        in: 0 ... maxHoursOfSelectedActivity,
                        step: 0.25
                    ).onChange(of: selectedHoursPerDay) {
                        _,
                            newValue in

                        if let index = activities.firstIndex(
                            of: selectedActivity
                        ) {
                            activities[index].hoursPerDay = newValue
                        } else {
                            print("⭐️ no index found")
                        }
                    }
                    Button("Edit") {
                        save()
                    }.buttonStyle(.borderedProminent)
                        .disabled(remainingHours <= 0)
                }
            }
            .padding()
            .navigationTitle("Activity Tracker")
            .toolbar {
                Button(action: {
                    cleanup()
                    withAnimation {
                        showAddSheet.toggle()
                    }
                }) {
                    Image(systemName: "plus")
                }
                EditButton()
            }
            .sheet(isPresented: $showAddSheet) {
                VStack {
                    Text("Add New Activity")
                    Spacer()
                    TextField("Enter new activity name", text: $selectedName)
                        .padding()
                        .background(.blue.gradient.opacity(0.2))
                        .clipShape(.rect(cornerRadius: 10))
                        .shadow(radius: 2)
                    HStack {
                        Text("Hours per day: \(selectedHoursPerDay.formatted())")
                        Spacer()
                    }.padding(.top)

                    Slider(
                        value: $selectedHoursPerDay,
                        in: 0 ... maxHoursOfSelectedActivity,
                        step: 0.25
                    )
                    Button("Add") {
                        withAnimation {
                            showAddSheet = false
                        }
                        addActivity()
                    }.buttonStyle(.borderedProminent)
                        .disabled(remainingHours <= 0 || selectedName.count < 2)
                    Spacer()
                }.padding()
            }
        }
    }

    private func save() {
        try? context.save()
        cleanup()
    }

    private func cleanup() {
        selectedName = ""
        selectedHoursPerDay = 0
        selectedActivity = nil
    }

    private func addActivity() {
        if selectedName.count < 2 || activities
            .contains(
                where: { $0.name.lowercased() == selectedName.lowercased()
                })
        {
            return
        }
        let activity = Activity(
            name: selectedName,
            hoursPerDay: selectedHoursPerDay
        )
        context.insert(activity)

        save()
    }

    private func removeActivity(at offsets: IndexSet) {
        for index in offsets {
            let activity = activities[index]
            context.delete(activity)
        }
        save()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Activity.self)
}
