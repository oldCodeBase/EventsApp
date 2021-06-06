//
//  EditEventViewModel.swift
//  EventsApp
//
//  Created by Ibragim Akaev on 06/06/2021.
//

import UIKit

final class EditEventViewModel {
    
    let title = "Edit"
    var onUpdate: () -> Void = {}
    
    enum Cell {
        case titleSubtitle(NewEventCellViewModel)
    }
    
    private(set) var cells: [Cell] = []
    weak var coordinator: EditEventCoordinator?
    
    private var nameCellViewModel: NewEventCellViewModel?
    private var dateCellViewModel: NewEventCellViewModel?
    private var backgroundImageCellViewModel: NewEventCellViewModel?
    private let cellBuilder: EventCellBuilder
    private let eventService: EventServiceProtocol
    private let event: Event
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter
    }()
    
    init(event: Event, cellBuilder: EventCellBuilder, eventService: EventServiceProtocol = EventService()) {
        self.event = event
        self.cellBuilder = cellBuilder
        self.eventService = eventService
    }
    
    func viewDidLoad() {
        setupCells()
        onUpdate()
    }
    
    func viewDidDisappear() {
        coordinator?.didFinish()
    }
    
    func numberOfRows() -> Int {
        return cells.count
    }
    
    func cell(for indexPath: IndexPath) -> Cell {
        return cells[indexPath.row]
    }
    
    func tappedDone() {
        guard let name = nameCellViewModel?.subtitle,
              let dateString = dateCellViewModel?.subtitle,
              let date = dateFormatter.date(from: dateString),
              let image = backgroundImageCellViewModel?.image else {
            return
        }
        let eventInputData = EventService.EventInputData(name: name, date: date, image: image)
        eventService.perform(.update(event), data: eventInputData)
        coordinator?.didFinishUpdateEvent()
    }
    
    func updateCell(indexPath: IndexPath, subtitle: String) {
        switch cells[indexPath.row] {
        case .titleSubtitle(let titleSubtitleCellViewModel):
            titleSubtitleCellViewModel.update(subtitle)
        }
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        switch cells[indexPath.row] {
        case .titleSubtitle(let newEventCellViewModel):
            guard newEventCellViewModel.cellType == .image else { return }
            coordinator?.showImagePicker() { image in
                newEventCellViewModel.update(image)
            }
        }
    }
}

private extension EditEventViewModel {
    
    func setupCells() {
        nameCellViewModel = cellBuilder.makeNewEventCellViewModel(.text)
        dateCellViewModel = cellBuilder.makeNewEventCellViewModel(.date) { [weak self] in
            self?.onUpdate()
        }
        backgroundImageCellViewModel = cellBuilder.makeNewEventCellViewModel(.image) { [weak self] in
            self?.onUpdate()
        }
        
        guard let nameCellViewModel = nameCellViewModel,
              let dateCellViewModel = dateCellViewModel,
              let backgroundImageCellViewModel = backgroundImageCellViewModel else {
            return
        }
        
        cells = [
            .titleSubtitle(nameCellViewModel),
            .titleSubtitle(dateCellViewModel),
            .titleSubtitle(backgroundImageCellViewModel)
        ]
        
        guard let name = event.name,
              let date = event.date,
              let imageData = event.image,
              let image = UIImage(data: imageData)
        else { return }
        
        nameCellViewModel.update(name)
        dateCellViewModel.update(date)
        backgroundImageCellViewModel.update(image)
    }
}

