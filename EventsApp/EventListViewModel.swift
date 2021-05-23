//
//  EventListViewModel.swift
//  EventsApp
//
//  Created by Ibragim Akaev on 23/05/2021.
//

import Foundation

final class EventListViewModel {
    
    let title = "Events"
    var coordinator: EventListCoordinator?
    
    func tappedAddEvent() {
        coordinator?.startAddEvent()
    }
}
