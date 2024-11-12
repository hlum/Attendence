//
//  NFCManager.swift
//  Attendence
//
//  Created by Hlwan Aung Phyo on 11/12/24.
//

import Foundation
import CoreNFC


class NFCManager:NSObject,NFCNDEFReaderSessionDelegate,ObservableObject{
    var onCardDataUpdate:((NFCData) -> ())?
    
    
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
            guard let cardData = processNFCNDEFMessage(message)else{
                print("Error processing NFC Data")
                continue
            }
            onCardDataUpdate?(cardData)
        }
    }
    
    
    func processNFCNDEFMessage(_ message:NFCNDEFMessage) -> NFCData?{
        let records = message.records
        for record in records{
            switch record.typeNameFormat {
            case .empty:
                print("empty")
            case .nfcWellKnown:
                print("nfcWellKnown")
            case .media:
                return decodeNFCData(from: record.payload)
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
        return nil
    }
    
    private func decodeNFCData(from data: Data) -> NFCData? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            let decodedData = try decoder.decode(NFCData.self, from: data)
            return decodedData
        } catch {
            print("Error decoding NFC data: \(error.localizedDescription)")
            print("Raw data: \(String(data: data, encoding: .utf8) ?? "Unable to print data as UTF-8")")
            return nil
        }
    }
    
}
