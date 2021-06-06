//
//  EventCellViewModel.swift
//  EventsApp
//
//  Created by Ibragim Akaev on 28/05/2021.
//

import UIKit
import CoreData

struct EventCellViewModel {
    
    private let date = Date()
    private let event: Event
    static let imageCache  = NSCache<NSString, UIImage>()
    private let imageQueue = DispatchQueue(label: "imageQueue", qos: .background)
    private var cacheKey: String { event.objectID.description }
    var onSelect: (NSManagedObjectID) -> Void = { _ in }
    
    var timeRemaningStrings: [String] {
        guard let eventDate = event.date else { return [] }
        return date.timeRemaining(until: eventDate)?.components(separatedBy: ",") ?? []
    }
    
    var dateText: String? {
        guard let date = event.date else { return nil }
        return date.convertDate()
    }
    
    var eventText: String? {
        event.name
    }
    
    var timeRemainingViewModel: TimeRemainingViewModel? {
        guard
            let eventDate = event.date,
            let timeRemainingParts = date.timeRemaining(until: eventDate)?.components(separatedBy: ",")
        else {
            return nil
        }
        
        return TimeRemainingViewModel(timeRemainingParts: timeRemainingParts, mode: .cell)
    }
    
    init(_ event: Event) {
        self.event = event
    }
    
    func loadImage(completion: @escaping (UIImage?) -> Void) {
        if let image = Self.imageCache.object(forKey: cacheKey as NSString) {
            completion(image)
        } else {
            imageQueue.async {
                guard let imageData = self.event.image, let image = UIImage(data: imageData) else {
                    completion(nil)
                    return
                }
                
                Self.imageCache.setObject(image, forKey: self.cacheKey as NSString)
                DispatchQueue.main.async { completion(image) }
            }
        }
    }
    
    func didSelect() {
        onSelect(event.objectID)
    }
}
