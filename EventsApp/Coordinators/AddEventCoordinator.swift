//
//  AddEventCoordinator.swift
//  EventsApp
//
//  Created by Ibragim Akaev on 23/05/2021.
//

import UIKit

final class AddEventCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    var parentCoordinator: EventListCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let addEventViewModel            = AddEventViewModel()
        let addEventViewController       = AddEventViewController()
        addEventViewModel.coordinator    = self
        addEventViewController.viewModel = addEventViewModel
        navigationController.present(addEventViewController, animated: true)
    }
    
    func didFinishAddEvent() {
        parentCoordinator?.childDidFinish(self)
    }
}
