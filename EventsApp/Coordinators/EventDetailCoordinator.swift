//
//  EventDetailCoordinator.swift
//  EventsApp
//
//  Created by Ibragim Akaev on 03/06/2021.
//

import UIKit
import CoreData

final class EventDetailCoordinator: EventUpdatingCoordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private let eventID: NSManagedObjectID
    var parentCoordinator: EventListCoordinator?
    var onUpdateEvent = { }
    
    init(eventID: NSManagedObjectID, navigationController: UINavigationController) {
        self.eventID = eventID
        self.navigationController = navigationController
    }
    
    func start() {
        let eventDetailViewController = EventDetailViewController()
        let eventDetailViewModel = EventDetailViewModel(eventId: eventID)
        eventDetailViewModel.coordinator = self
        onUpdateEvent = {
            eventDetailViewModel.reload()
            self.parentCoordinator?.onUpdateEvent()
        }
        eventDetailViewController.viewModel = eventDetailViewModel
        navigationController.pushViewController(eventDetailViewController, animated: true)
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    func onEditEvent(event: Event) {
        let editEventCoordinator = EditEventCoordinator(event: event,
                                                        navigationController: navigationController)
        editEventCoordinator.parentCoordinator = self
        childCoordinators.append(editEventCoordinator)
        editEventCoordinator.start()
    }
    
    func childDidFinish(_ childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
            return childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
}
