//
//  TestCoreDataStack.swift
//  GenGenTests
//
//  Created by Ceren Gazioglu Majoor on 07/04/2023.
//

import Foundation
import CoreData
@testable import GenGen

class TestCoreDataStack: CoreDataStack {
    override init() {
        super.init()

        let inMemoryStoreDescription = NSPersistentStoreDescription()
        inMemoryStoreDescription.type = NSInMemoryStoreType

        let inMemoryContainer = NSPersistentContainer(name: CoreDataStack.modelName, managedObjectModel: CoreDataStack.model)
        inMemoryContainer.persistentStoreDescriptions = [inMemoryStoreDescription]

        inMemoryContainer.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        persistentContainer = inMemoryContainer
    }
}
