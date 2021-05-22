//
//  CoreDataManager.swift
//  EventsApp
//
//  Created by Ibragim Akaev on 22/05/2021.
//

import CoreData
import UIKit

final class CoreDataManager {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "EventsApp")
        persistentContainer.loadPersistentStores { _, error in
            print(error?.localizedDescription ?? "")
        }
        return persistentContainer
    }()
    
    var moc: NSManagedObjectContext { persistentContainer.viewContext }
    
    func saveEvent(name: String, date: Date, image: UIImage) {
        let event = Event(context: moc)
        let imageData = image.jpegData(compressionQuality: 1)
        event.setValue(name, forKey: "name")
        event.setValue(date, forKey: "date")
        event.setValue(imageData, forKey: "image")
        
        do { try moc.save() } catch { print(error) }
    }
    
    func fetchEvents() -> [Event] {
        do {
            let fetchRequest = NSFetchRequest<Event>(entityName: "Event")
            let events = try moc.fetch(fetchRequest)
            return events
        } catch {
            print(error)
            return []
        }
    }
}
