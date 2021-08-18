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
    
    
    //    private let context = StorageManager.shared.persistentContainer.viewContext
    
    // MARK: - Core Data stack
    
    //Сохраняет данные при падении приложения
    func applicationWillTerminate(_ application: UIApplication) {
        saveContext()
    }
    
    // Отвечает за подключение постоянного хранилища
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
    
    //Сохраняет данные в контекст
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
    
    
    // Получаем контекст
    func getContext() -> NSManagedObjectContext {
        StorageManager.shared.persistentContainer.viewContext
    }
    
    //Получаем сущность Task
    func getEntity( complition: @escaping (Task) -> Void) {
        let context = StorageManager.shared.persistentContainer.viewContext
        print(context)
        
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return }
        guard let task = NSManagedObject(entity: entityDescription, insertInto: context) as? Task else { return }
        complition(task)
    }
    
    // Получаем даннные из контекста
    func fetchData(task: @escaping ([Task]) -> Void) {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        let context = getContext()
        print(context)
        
        do {
            let taskList = try context.fetch(fetchRequest)
            task(taskList)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    // Обновляем данные
    func updateData() {
    }
    
    // Удаляем данные
    func deleteData() {
        
    }
}
