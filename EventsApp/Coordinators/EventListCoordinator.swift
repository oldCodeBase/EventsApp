//
//  EventListCoordinator.swift
//  EventsApp
//
//  Created by Ibragim Akaev on 22/05/2021.
//

import UIKit
import CoreData

final class EventListCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    var onSaveEvent = {}
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let eventListViewController       = EventListViewController()
        let eventListViewModel            = EventListViewModel()
        eventListViewModel.coordinator    = self
        onSaveEvent                       = eventListViewModel.reload
        eventListViewController.viewModel = eventListViewModel
        navigationController.setViewControllers([eventListViewController],
                                                animated: false)
    }
    
    func startAddEvent() {
        let addEventCoordinator = AddEventCoordinator(navigationController: navigationController)
        childCoordinators.append(addEventCoordinator)
        addEventCoordinator.parentCoordinator = self
        addEventCoordinator.start()
    }
    
    func childDidFinish(_ childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { coordinator in
            return childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
    
    func onSelect(_ id: NSManagedObjectID) {
        let eventDetailCoordinator = EvenDetailCoordinator(eventID: id, navigationController: navigationController)
        childCoordinators.append(eventDetailCoordinator)
        eventDetailCoordinator.start()
    }
}
