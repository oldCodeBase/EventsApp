//
//  EventListCoordinator.swift
//  EventsApp
//
//  Created by Ibragim Akaev on 22/05/2021.
//

import UIKit

final class EventListCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let eventListViewController = EventListViewController()
        navigationController.setViewControllers([eventListViewController],
                                                animated: false)
    }
}
