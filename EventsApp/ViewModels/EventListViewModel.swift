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
    init(coreDataManager: CoreDataManager = .shared) {
        self.coreDataManager = coreDataManager
    }
    func viewDidLoad() {
        reload()
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
    
    func reload() {
        let events = coreDataManager.fetchEvents()
        cells = events.map {
            var evenCellViewModel = EventCellViewModel($0)
            if let coordinator = coordinator {
                evenCellViewModel.onSelect = coordinator.onSelect
            }
            return .event(evenCellViewModel)
        }
        onUpdate()
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        switch cells[indexPath.row] {
        case .event(let eventCellViewModel):
            eventCellViewModel.didSelect()
        }
    }
}
