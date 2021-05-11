//
//  Entry.swift
//  Journal
//
//  Created by Jaymond Richardson on 5/10/21.
//

import Foundation
import CloudKit

struct EntryStrings {
    static let recordTypeKey = "Entry"
    fileprivate static let bodyKey = "body"
    fileprivate static let titleKey = "title"
    fileprivate static let ckRecordID = "ckRecordID"
    fileprivate static let timestampKey = "timestamp"
}

class Entry {
    var title: String
    var body: String
    var ckRecordID: CKRecord.ID
    var timestamp: Date
    
    init(title: String, body: String, ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString), timestamp: Date = Date()) {
        self.title = title
        self.body = body
        self.ckRecordID = ckRecordID
        self.timestamp = timestamp
        
    }
}

extension Entry {
    
    convenience init?(ckRecord: CKRecord) {
        guard let body = ckRecord[EntryStrings.bodyKey] as? String,
              let title = ckRecord[EntryStrings.titleKey] as? String,
              let timestamp = ckRecord[EntryStrings.timestampKey] as? Date
              
              else {return nil}
        self.init(title: title, body: body, timestamp: timestamp)
        
        
    }
}

extension CKRecord {
    
    convenience init(entry: Entry) {
        
        self.init(recordType: EntryStrings.recordTypeKey)
        self.setValuesForKeys([
            EntryStrings.bodyKey : entry.body,
            EntryStrings.titleKey : entry.title,
//            EntryStrings.ckRecordID : entry.ckRecordID,
            EntryStrings.timestampKey : entry.timestamp
            
        ])
    }
}
