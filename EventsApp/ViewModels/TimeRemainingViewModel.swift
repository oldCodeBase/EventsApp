//
//  TimeRemainingViewModel.swift
//  EventsApp
//
//  Created by Ibragim Akaev on 05/06/2021.
//

import UIKit

final class TimeRemainingViewModel {
    
    enum Mode { case cell, detail }
    private let mode: Mode
    let timeRemainingParts: [String]
    
    var fontSize: CGFloat {
        switch mode {
        case .cell:   return 25
        case .detail: return 60
        }
    }
    
    var alignment: UIStackView.Alignment {
        switch mode {
        case .cell:   return .trailing
        case .detail: return .center
        }
    }
    
    init(timeRemainingParts: [String], mode: Mode) {
        self.timeRemainingParts = timeRemainingParts
        self.mode = mode
    }
}
