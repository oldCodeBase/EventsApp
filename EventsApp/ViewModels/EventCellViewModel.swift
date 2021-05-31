//
//  EventCellViewModel.swift
//  EventsApp
//
//  Created by Ibragim Akaev on 28/05/2021.
//

import UIKit

struct EventCellViewModel {
    
    private let date = Date()
    private let event: Event
    private static let imageCache = NSCache<NSString, UIImage>()
    private var cacheKey: String { event.objectID.description }
    
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
    
    init(_ event: Event) {
        self.event = event
    }
    
    func loadImage(completion: (UIImage?) -> Void) {
        if let image = Self.imageCache.object(forKey: cacheKey as NSString) {
            completion(image)
        } else {
            guard let imageData = event.image, let image = UIImage(data: imageData) else {
                completion(nil)
                return
            }
            
            Self.imageCache.setObject(image, forKey: cacheKey as NSString)
            completion(image)
        }
    }
}
