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
        case titleSubTitle(NewEventCellViewModel)
    }
    
    private(set) var cells: [AddEventViewModel.Cell] = []
    var coordinator: AddEventCoordinator?
    private var nameNewEventCellViewModel: NewEventCellViewModel?
    private var dateNewEventCellViewModel: NewEventCellViewModel?
    private var imageNewEventCellViewModel: NewEventCellViewModel?
    private let eventCellBuilder: EventCellBuilder
    private let coreDataManager: CoreDataManager
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        return dateFormatter
    }()
    
    init(cellBuilder: EventCellBuilder, coreDataManager: CoreDataManager) {
        self.eventCellBuilder = cellBuilder
        self.coreDataManager = coreDataManager
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
        guard let name = nameNewEventCellViewModel?.subtitle,
              let dateString = dateNewEventCellViewModel?.subtitle,
              let image = imageNewEventCellViewModel?.image,
              let date = dateFormatter.date(from: dateString)
        else { return }
        coreDataManager.saveEvent(name: name, date: date, image: image)
        coordinator?.didFinishSaveEvent()
    }
    
    func tappedClose() {
        print("Close button tapped")
    }
    
    func updateCell(indexPath: IndexPath, subtitle: String) {
        switch cells[indexPath.row] {
        case .titleSubTitle(let titleSubTitleViewModel):
            titleSubTitleViewModel.update(subtitle)
        }
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        switch cells[indexPath.row] {
        case .titleSubTitle(let titleSubtitleCellViewModel):
            guard titleSubtitleCellViewModel.cellType == .image else { return }
            coordinator?.showImagePicker { image in
                titleSubtitleCellViewModel.update(image)
            }
        }
    }
}

private extension AddEventViewModel {
    func setupCells() {
        nameNewEventCellViewModel = eventCellBuilder.makeNewEventCellViewModel(.text)
        
        dateNewEventCellViewModel = eventCellBuilder.makeNewEventCellViewModel(.date) { [weak self] in
            self?.onUpdate()
        }
        
        imageNewEventCellViewModel = eventCellBuilder.makeNewEventCellViewModel(.image) { [weak self] in
            self?.onUpdate()
        }
        
        guard let nameNewEventCellViewModel  = nameNewEventCellViewModel,
              let dateNewEventCellViewModel  = dateNewEventCellViewModel,
              let imageNewEventCellViewModel = imageNewEventCellViewModel else { return }
        
        cells = [.titleSubTitle(nameNewEventCellViewModel),
                 .titleSubTitle(dateNewEventCellViewModel),
                 .titleSubTitle(imageNewEventCellViewModel)]
    }
}
