//
//  EventListViewModel.swift
//  EventsApp
//
//  Created by Ibragim Akaev on 23/05/2021.
//

import Foundation

final class EventListViewModel {
    
    let title = "Events"
    var onUpdate = {}
    var coordinator: EventListCoordinator?
    enum Cell { case event(EventCellViewModel) }
    private(set) var cells: [Cell] = []
    private let coreDataManager: CoreDataManager
    init(coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.coreDataManager = coreDataManager
    }
    func viewDidLoad() {
        let events = coreDataManager.fetchEvents()
        cells = events.map {
            .event(EventCellViewModel($0))
        }
        
        onUpdate()
    }
    
    func tappedAddEvent() {
        coordinator?.startAddEvent()
    }
    
    func numberOfRows() -> Int {
        return cells.count
    }
    
    func cell(at indexPath: IndexPath) -> Cell {
        return cells[indexPath.row]
    }
}
