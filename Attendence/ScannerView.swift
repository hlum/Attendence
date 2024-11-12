//
//  ContentView.swift
//  Attendence
//
//  Created by Hlwan Aung Phyo on 11/12/24.
//

import SwiftUI

final class ScannerViewModel:ObservableObject {
    @Published var cardData:String = ""
    var nfcManager:NFCManager
    
    init(){
        nfcManager = NFCManager()
        nfcManager.onCardDataUpdate = {[weak self] cardData in
            DispatchQueue.main.async {
                self?.cardData = cardData
            }
        }
    }
    
    
    func scan(){
        nfcManager.scan()
    }
}

struct ScannerView: View {
    @ObservedObject var vm = ScannerViewModel()
    var body: some View {
        VStack {
            Text(vm.cardData)
                .foregroundStyle(Color.black)
                .font(.title)
            Button {
                vm.scan()
            } label: {
                Text("Scan")
            }

        }
        .padding()
    }
}

#Preview {
    ScannerView()
}
