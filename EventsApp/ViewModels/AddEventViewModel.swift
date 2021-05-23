//
//  AddEventViewModel.swift
//  EventsApp
//
//  Created by Ibragim Akaev on 23/05/2021.
//

import Foundation

final class AddEventViewModel {
    
    var coordinator: AddEventCoordinator?
    
    func viewDidDisappear() {
        coordinator?.didFinishAddEvent()
    }
}
