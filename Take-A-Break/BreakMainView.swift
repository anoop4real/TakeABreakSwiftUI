//
//  BreakMainView.swift
//  Take-A-Break
//
//  Created by Anoop M on 2020-06-28.
//  Copyright © 2020 Anoop M. All rights reserved.
//

import SwiftUI

struct BreakMainView: View {
    @ObservedObject var dataStore = TakeABreakDataStore.shared()
    @State private var breakText = ""
    @State private var showReminderText = false
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Seconds Elapsed: ")
                Text("\(dataStore.tick)")
            }
            Divider()
            HStack {
                Picker(selection: $dataStore.picked, label: Text("Set Timer:")) {
                    ForEach(0 ..< dataStore.intervalCount(), id: \.self) {
                        Text(self.dataStore.intervalAt(index: $0))
                    }
                }
                .pickerStyle(PopUpButtonPickerStyle())
                .frame(width: 150)
            }
            HStack {
                Button(self.showReminderText ? "Done" : "Set Text", action: {
                    self.showReminderText.toggle()
                }).buttonStyle(CapsuleStyle())
                if self.showReminderText {
                    TextField(self.dataStore.getDisplayStringfromDefaults(), text: $breakText, onEditingChanged: { _ in
                    }) {
                        // Save to user defaults
                        self.dataStore.storeTextToUserDefaults(text: self.breakText)
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 200)
                }
            }
            Divider()
            HStack(spacing: 180) {
                Button(action: {
                    self.dataStore.stopTimer()
                }) {
                    Text("Stop")
                }.buttonStyle(RoundBorderStyle())
                Button(action: {
                    self.dataStore.startTimer()
                }) {
                    Text("Start")
                }.buttonStyle(RoundBorderStyle())
            }
        }
        .frame(minWidth: 325, maxWidth: 325, alignment: .leading)
        .padding(10)
        .alert(isPresented: $dataStore.shouldShowAlert, content: {
            Alert(title: Text("Take A Break"), message: Text(self.dataStore.messageToDisplay()), dismissButton: .default(Text("OK")))
        })
    }
}

struct BreakMainView_Previews: PreviewProvider {
    static var previews: some View {
        BreakMainView()
    }
}
