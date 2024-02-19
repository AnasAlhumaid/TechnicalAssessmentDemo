//
//  CoreDataModel.swift
//  TechnicalAssessmentDemo
//
//  Created by Anas Hamad on 2/19/24.
//

import Foundation
import CoreData

protocol Model {
    
}

extension Model where Self: NSManagedObject {
    
    func save() throws {
        try CoreDataProvider.shared.viewContext.save()
    }
    
    func delete() throws {
        CoreDataProvider.shared.viewContext.delete(self)
        try save()
    }
    
    static var all: NSFetchRequest<Self> {
        let request = NSFetchRequest<Self>(entityName: String(describing: self))
        request.sortDescriptors = []
        return request
    }
    func deleteAllData() throws {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "UserCoreData")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        // Perform the batch delete
        try CoreDataProvider.shared.persistentContainer.persistentStoreCoordinator.execute(deleteRequest, with: CoreDataProvider.shared.viewContext)

        // Save the context
        try save()
    }
    
}



