//
//  EventCellBuilder.swift
//  EventsApp
//
//  Created by Ibragim Akaev on 26/05/2021.
//

import UIKit

struct EventCellBuilder {
    func makeNewEventCellViewModel(_ type: NewEventCellViewModel.CellType, onCellUpdate: (() -> Void)? = nil) -> NewEventCellViewModel {
        
        switch type {
        case .text:
            return NewEventCellViewModel(title: "Name",
                                         subtitle: "",
                                         placeholder: "Add a name",
                                         type: .text,
                                         onUpdate: onCellUpdate)
        case .date:
            return NewEventCellViewModel(title: "Date",
                                         subtitle: "",
                                         placeholder: "Select a date",
                                         type: .date,
                                         onUpdate: onCellUpdate)
        case .image:
            return NewEventCellViewModel(title: "Background",
                                         subtitle: "",
                                         placeholder: "",
                                         type: .image,
                                         onUpdate: onCellUpdate)
        }
    }
}
