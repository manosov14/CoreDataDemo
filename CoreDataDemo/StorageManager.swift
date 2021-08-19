//
//  storage manager.swift
//  CoreDataDemo
//
//  Created by Михаил on 17.08.2021.
//

import CoreData
import UIKit

class StorageManager {
    
    private init() {}
    static let shared = StorageManager()

    // MARK: - Core Data stack
    
    func applicationWillTerminate(_ application: UIApplication) {
        saveContext()
    }
    
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataDemo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = getContext()
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func getContext() -> NSManagedObjectContext {
        StorageManager.shared.persistentContainer.viewContext
    }
    
    func getEntity( complition: @escaping (Task) -> Void) {
        let context = StorageManager.shared.persistentContainer.viewContext
        print(context)
        
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return }
        guard let task = NSManagedObject(entity: entityDescription, insertInto: context) as? Task else { return }
        complition(task)
    }
    
    func fetchDataFromContext(task: @escaping ([Task]) -> Void) {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        let context = getContext()
        
        do {
            let taskList = try context.fetch(fetchRequest)
            task(taskList)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func updateDataToContext() {
    }
    
    func deleteDataFromContext(at indexPath: IndexPath) {
//        let fetchRequest = fetchDataFromContext { task in
//            let context = self.getContext()
//            guard let oldTaskFromBD = taskList?.first(where: { $0.name == task }) else {
//                return
//
//
//        }
//
//        }
//        context.delete(oldTaskFromBD)
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch let error {
//                print(error.localizedDescription)
//            }
//        }
    }
}

