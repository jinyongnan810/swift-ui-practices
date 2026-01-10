//
//  SheetZoomTransition.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2026/01/10.
//

import SwiftUI

struct SheetZoomTransition: View {
    @State private var isPresented: Bool = false
    @Namespace private var infoSpace
    var body: some View {
        ZStack {
            Image("sunset").scaledToFit().ignoresSafeArea()
        }
        .navigationTitle("Sheet Transition")
        // display title in the toolbar
        .toolbarTitleDisplayMode(.inlineLarge)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Info", systemImage: "info") {
                    isPresented.toggle()
                }
            }.matchedTransitionSource(id: "Info", in: infoSpace)
        }
        .sheet(isPresented: $isPresented) {
            InfoView()
                // sheet sizes. glass effect in medium size
                .presentationDetents([.medium, .large])
                // sheet zooms out of button
                .navigationTransition(.zoom(sourceID: "Info", in: infoSpace))
        }
    }
}

struct InfoView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            ScrollView {
                Text("""
                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut aliquam mattis ante nec pretium. Aenean auctor turpis vitae sapien pulvinar, vitae eleifend velit suscipit. Ut ac tincidunt turpis, non efficitur sem. Vivamus lobortis sapien sed pellentesque lobortis. Curabitur pharetra auctor diam vitae iaculis. In ac euismod massa. Donec luctus sapien at leo gravida hendrerit.

                Curabitur vitae metus quis libero accumsan varius. Nullam nec tellus eros. Maecenas porttitor hendrerit tellus at mollis. Nunc vel nunc arcu. Nulla facilisi. Sed id mauris massa. Fusce efficitur nisi non dui tempor pretium. Proin ante nisl, pellentesque eu elit in, tempus tempor dolor. Donec maximus, erat in aliquet blandit, elit velit tristique lacus, vel commodo tellus odio sed tortor. Nunc convallis ligula nulla.

                Fusce ut urna vitae risus iaculis commodo eleifend quis dolor. Curabitur magna augue, vehicula suscipit consequat pretium, tincidunt et ligula. Donec tempor tellus vel vehicula pellentesque. Nam mattis, leo at aliquam vulputate, lectus augue efficitur erat, hendrerit posuere ipsum dolor ut ex. Mauris placerat, neque at viverra posuere, elit velit efficitur libero, vel commodo libero metus vitae tortor. Duis nec condimentum mi, sit amet scelerisque eros. Phasellus maximus, urna vel egestas tempor, tortor urna malesuada elit, ut tempor tellus lacus vitae magna. Nam consequat in velit vitae elementum.

                Praesent dictum luctus metus a aliquet. Fusce vulputate egestas libero sed volutpat. Morbi egestas ornare ultricies. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec nisi odio, consequat ac risus et, condimentum lacinia libero. Proin pellentesque faucibus libero ut congue. Duis aliquam tortor et pharetra pretium. Curabitur consequat tincidunt rhoncus. In a massa laoreet, tincidunt tortor a, gravida massa. Aenean eu tempus dui.

                Nulla rhoncus at mauris non lobortis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Sed sed semper turpis. Cras sagittis a nulla in posuere. Etiam iaculis, lectus a faucibus faucibus, lacus risus auctor mi, sed pretium tellus metus vitae nibh. Suspendisse volutpat mauris id velit semper tempor. Nunc vitae ultrices elit. Sed at bibendum libero, quis varius nunc. Nulla malesuada in massa at ultricies. Aenean est lacus, blandit sagittis massa sed, pretium euismod lacus. Fusce condimentum lorem vitae scelerisque ultricies. In hac habitasse platea dictumst. Cras rhoncus rutrum risus, et vehicula massa dapibus ut. Morbi ultrices vel orci eu tristique.
                """)
            }
            .padding(.init(top: 70, leading: 10, bottom: 10, trailing: 10))
            .ignoresSafeArea()
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", systemImage: "xmark") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SheetZoomTransition()
    }
}
