//
//  NFCData.swift
//  Attendence
//
//  Created by Hlwan Aung Phyo on 11/12/24.
//

import Foundation


struct NFCData: Codable {
    let studentId:String
    let name : String
    var date: Date
    var birthDate:Date
    var className:String
    var major:String
    var profileUrl:String
    
    
    
    
    enum CodingKeys: String, CodingKey {
        case studentId = "student_id"
        case name = "name"
        case date = "date"
        case birthDate = "birth_date"
        case className = "class_name"
        case major = "major"
        case profileUrl = "profile_url"
    }
    
    //classNameからCM ならモバイルアプリケーション開発科とか計算して出せそう　後回し
}
