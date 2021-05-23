//
//  NewEventCellViewModel.swift
//  EventsApp
//
//  Created by Ibragim Akaev on 23/05/2021.
//

import UIKit

final class NewEventCellViewModel {
    
    enum CellType { case text, date, image }
    
    let title: String
    let cellType: CellType
    let placeholder: String
    private(set) var image: UIImage?
    private(set) var subtitle: String
    private(set) var onCellUpdate: () -> Void = {}
    
    init(title: String, subtitle: String, placeholder: String, type: CellType, onUpdate: @escaping () -> Void) {
        self.title        = title
        self.subtitle     = subtitle
        self.placeholder  = placeholder
        self.cellType     = type
        self.onCellUpdate = onUpdate
    }
    
    func update(_ subtitle: String) {
        self.subtitle = subtitle
    }
    
    func update(_ date: Date) {
        let stringDate = date.convertDate()
        self.subtitle = stringDate
        onCellUpdate()
    }
    
    func update(_ image: UIImage) {
        self.image = image
        onCellUpdate()
    }
}
