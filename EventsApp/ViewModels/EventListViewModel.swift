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
    
    func viewDidLoad() {
        cells = [.event(EventCellViewModel()), .event(EventCellViewModel())]
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
