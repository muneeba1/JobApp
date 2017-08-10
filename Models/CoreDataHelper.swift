//
//  CoreDataHelper.swift
//  JobApp
//
//  Created by Muneeba Khatoon on 8/10/17.
//  Copyright © 2017 Muneeba Khatoon. All rights reserved.
//

import Foundation

import CoreData
import UIKit

class CoreDataHelper {
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let persistentContainer = appDelegate.persistentContainer
    static let managedContext = persistentContainer.viewContext
    //static methods will go here
    
    static func newJob() -> SavedJobs {
        let job = NSEntityDescription.insertNewObject(forEntityName: "SavedJobs", into: managedContext) as! SavedJobs
        return job
    }
    
    static func saveJob() {do {
        try managedContext.save()
    } catch let error as NSError {
        print("Could not save \(error)")
        }
    }
    
    static func delete(job: SavedJobs) {
        managedContext.delete(job)
        saveJob()
    }
    
    static func retrieveJobs() -> [SavedJobs] {
        let fetchRequest = NSFetchRequest<SavedJobs>(entityName: "SavedJobs")
        do {
            let results = try managedContext.fetch(fetchRequest)
            return results
        } catch let error as NSError {
            print("Could not fetch \(error)")
        }
        return []
    }
    
}
