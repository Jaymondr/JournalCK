//
//  EntryController.swift
//  Journal
//
//  Created by Jaymond Richardson on 5/10/21.
//

import Foundation
import CloudKit


class EntryController {
    
    let privateDB = CKContainer.default().privateCloudDatabase
    
    static let shared = EntryController()
    
    var entries: [Entry] = []
    
    //MARK: - CRUD Functions
    
    func createEntryWith(title: String, body: String, completion: @escaping (Result<Entry?, EntryError>) -> Void) {
        let newEntry = Entry(title: title, body: body)
        saveEntry(entry: newEntry, completion: completion)
    }
    
    func saveEntry(entry: Entry, completion: @escaping (Result<Entry?, EntryError>) -> Void) {
        let entryRecord = CKRecord(entry: entry)
        privateDB.save(entryRecord) { record, error in
            if let error = error {
                return completion(.failure(.ckError(error)))
            }
            
            guard let record = record,
                  let savedEntry = Entry(ckRecord: record) else {return completion(.failure(.couldNotUnwrap))}
            print("Saved Entry")
            
            self.entries.insert(savedEntry, at: 0)
            
            DispatchQueue.main.async { completion(.success(savedEntry)) }
        }
    }
    
    func fetchEntriesWith(completion: @escaping(_ result: Result<[Entry]?, EntryError>) -> Void ) {
        
        let fetchAllPredicates = NSPredicate(value: true)
        
        let query = CKQuery(recordType: EntryStrings.recordTypeKey, predicate: fetchAllPredicates)
        privateDB.perform(query, inZoneWith: nil) { records, error in
            if let error = error {return completion(.failure(.ckError(error)))}
            
            
            guard let records = records else {return completion(.failure(.couldNotUnwrap))}
            print("You did the Fetching of the Entries!")
            
            let entries = records.compactMap({Entry(ckRecord: $0)})
            
            self.entries = entries
            
            DispatchQueue.main.async {completion(.success(entries))}
            
            
        }
    }
    
}
