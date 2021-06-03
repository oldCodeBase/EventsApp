//
//  EvenDetailCoordinator.swift
//  EventsApp
//
//  Created by Ibragim Akaev on 03/06/2021.
//

import UIKit
import CoreData

final class EvenDetailCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private let eventID: NSManagedObjectID
    
    init(eventID: NSManagedObjectID, navigationController: UINavigationController) {
        self.eventID              = eventID
        self.navigationController = navigationController
    }
    
    func start() {
        let eventDetailViewController = EventDetailViewController()
        eventDetailViewController.viewModel = EventDetailViewModel.init(eventID: eventID)
        navigationController.pushViewController(eventDetailViewController, animated: true)
    }
}
