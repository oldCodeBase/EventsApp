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
    
    func viewDidLoad() {
        cells = [
            .titleSubTitle(NewEventCellViewModel(title: "Name",
                                                  subtitle: "",
                                                  placeholder: "Add a name",
                                                  type: .text, onUpdate: {} )),
            
            .titleSubTitle(NewEventCellViewModel(title: "Date",
                                                  subtitle: "",
                                                  placeholder: "Select a date",
                                                  type: .date, onUpdate: { [weak self] in
                                                    self?.onUpdate()
                                                  })),
            .titleSubTitle(NewEventCellViewModel(title: "Background",
                                                  subtitle: "",
                                                  placeholder: "",
                                                  type: .image, onUpdate: { [weak self] in
                                                    self?.onUpdate()
                                                  }))
        ]
        onUpdate()
    }
    
    func viewDidDisappear() {
        coordinator?.didFinishAddEvent()
    }
    
    func numberOfRows() -> Int {
        return cells.count
    }
    
    func cell(for indexPath: IndexPath) -> Cell {
        return cells[indexPath.row]
    }
    
    func tappedDone() {
        print("Done button tapped")
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
