//
//  CoreDataStack.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 07/04/2023.
//

import Foundation
import CoreData

open class CoreDataStack {

    public static let modelName = "DataModel"

    public static let model: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()

    public lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: CoreDataStack.modelName, managedObjectModel: CoreDataStack.model)
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
                return
            }
        }
        return container
    }()

    public init() {}

    // MARK: - Core Data Saving support
    @discardableResult
    func saveContext() throws -> Error? {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            try context.save()
        }
        return nil
    }
}
