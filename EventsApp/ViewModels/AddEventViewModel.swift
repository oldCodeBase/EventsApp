//
//  AddEventViewModel.swift
//  EventsApp
//
//  Created by Ibragim Akaev on 23/05/2021.
//

import Foundation

final class AddEventViewModel {
    
    let title = "Add"
    var onUpdate: () -> Void = {}
    
    enum Cell {
        case titleSubtitle(NewEventCellViewModel)
    }
    
    private(set) var cells: [Cell] = []
    weak var coordinator: AddEventCoordinator?
    
    private var nameCellViewModel: NewEventCellViewModel?
    private var dateCellViewModel: NewEventCellViewModel?
    private var backgroundImageCellViewModel: NewEventCellViewModel?
    private let cellBuilder: EventCellBuilder
    private let eventService: EventServiceProtocol
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter
    }()
    
    init(cellBuilder: EventCellBuilder, eventService: EventServiceProtocol = EventService()) {
        self.cellBuilder  = cellBuilder
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
        guard let name       = nameCellViewModel?.subtitle,
              let dateString = dateCellViewModel?.subtitle,
              let date       = dateFormatter.date(from: dateString),
              let image      = backgroundImageCellViewModel?.image else {
            return
        }
        let eventInputData = EventService.EventInputData(name: name, date: date, image: image)
        eventService.perform(.add, data: eventInputData)
        coordinator?.didFinishSaveEvent()
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

private extension AddEventViewModel {
    
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
    }
}
