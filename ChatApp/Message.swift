//
//  Message.swift
//  ChatApp
//
//  Created by user220390 on 28/02/1401 AP.
//

import Foundation



enum OSType : String, CustomStringConvertible{
    case ANDROID
    case IOS
    
    var description: String {
        switch self {
        case .IOS: return "IOS"
        case .ANDROID: return "ANDROID"
        }
    }
}
class Message {
    var senderName: String
    var content: String
    var senderOSType: OSType
    var time: String
    
    init(senderName: String,
         content: String)
    {
        self.senderName = senderName
        self.content = content
        self.senderOSType = OSType.IOS
        self.time = getDateString()
        
    }
    
    init(dict: [String:String]) {
        self.senderName = dict["senderName"]!
        self.content = dict["content"]!
        self.senderOSType = OSType(rawValue: dict["senderOSType"]!)!
        self.time = dict["time"]!
    }
    
    func CreateView() -> MessageView {
        let messageView = MessageView()
        messageView.SenderName.text = self.senderName
        messageView.Content.text = self.content
        messageView.SenderOSType.text = self.senderOSType.description
        messageView.Time.text = self.time
        return messageView
    }
    
    func toDict() -> [String : String]{
        return  [
            "senderName" : self.senderName,
            "content" : self.content,
            "senderOSType" : self.senderOSType.description,
            "time" : self.time
        ]
    }
    
    
}


func getDateString() -> String {
    let currentDateTime = Date()
    
    let formatter = DateFormatter()
    formatter.timeStyle = .medium
    formatter.dateStyle = .long
    
    return formatter.string(from: currentDateTime)
}

