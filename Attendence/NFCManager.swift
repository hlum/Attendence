//
//  NFCManager.swift
//  Attendence
//
//  Created by Hlwan Aung Phyo on 11/12/24.
//

import Foundation
import CoreNFC


class NFCManager:NSObject,NFCNDEFReaderSessionDelegate,ObservableObject{
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: any Error) {
        if error.localizedDescription.contains("First NDEF tag read"){
//            print("card read successfully")
        }else{
            print("Error: \(error.localizedDescription)")
        }
    }
    
    
    private var readerSession:NFCNDEFReaderSession?
    
    func scan(){
        //Reader session作成　pass as delegate
        guard NFCNDEFReaderSession.readingAvailable else{
            print("NFC not available")
            return
        }
        
        readerSession = NFCNDEFReaderSession(delegate: self, queue: DispatchQueue.main, invalidateAfterFirstRead: true)
        readerSession?.alertMessage = "Get Closer the Tag to Scan"
        readerSession?.begin()
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        print("NFCNDEFMessage: \(messages[0].records[0].description)")
        
    }
    
    
}
