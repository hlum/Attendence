//
//  NFCManager.swift
//  Attendence
//
//  Created by Hlwan Aung Phyo on 11/12/24.
//

import Foundation
import CoreNFC


class NFCManager:NSObject,NFCNDEFReaderSessionDelegate,ObservableObject{
    var onCardDataUpdate:((String) -> ())?
    
    
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
        for message in messages{
            let cardData = processNFCNDEFMessage(message)
            onCardDataUpdate?(cardData)
        }
    }
    
    
    func processNFCNDEFMessage(_ message:NFCNDEFMessage) -> String{
        let records = message.records
        var message :String = "Opps"
        for record in records{
            switch record.typeNameFormat {
                
            case .empty:
                print("empty")
            case .nfcWellKnown:
                message = String(data: record.payload, encoding: .utf8) ?? "Can't encode to UTF8"
            case .media:
                print("media")
            case .absoluteURI:
                print("absoluteURI")
            case .nfcExternal:
                print("nfcExternal")
            case .unknown:
                print("unknown")
            case .unchanged:
                print("unchanged")
            @unknown default:
                print("unknown default")
            }
            
        }
        return message

    }
    
    
}
