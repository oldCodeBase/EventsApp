//
//  TimeRemainingStackView.swift
//  EventsApp
//
//  Created by Ibragim Akaev on 05/06/2021.
//

import UIKit

final class TimeRemainingStackView: UIStackView {
    private let timeRemainingLabels = [UILabel(), UILabel(), UILabel(), UILabel()]

    func setup() {
        timeRemainingLabels.forEach { addArrangedSubview($0) }
        axis = .vertical
    }
    
    func update(with viewModel: TimeRemainingViewModel) {
        alignment = viewModel.alignment
        translatesAutoresizingMaskIntoConstraints = false
        
        timeRemainingLabels.forEach {
            $0.text = ""
            $0.font = .systemFont(ofSize: viewModel.fontSize, weight: .medium)
            $0.textColor = .white
        }
        
        viewModel.timeRemainingParts.enumerated().forEach {
            timeRemainingLabels[$0.offset].text = $0.element
        }
    }
}
