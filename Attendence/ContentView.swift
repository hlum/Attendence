//
//  ContentView.swift
//  Attendence
//
//  Created by Hlwan Aung Phyo on 11/12/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var readerManager = NFCManager()
    var body: some View {
        VStack {
            Button {
                readerManager.scan()
            } label: {
                Text("Scan")
            }

        }
        .padding()
    }
}

#Preview {
    ContentView()
}
