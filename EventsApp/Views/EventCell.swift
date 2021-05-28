//
//  EventCell.swift
//  EventsApp
//
//  Created by Ibragim Akaev on 28/05/2021.
//

import UIKit

final class EventCell: UITableViewCell {
    private let yearLabel       = UILabel()
    private let monthLabel      = UILabel()
    private let weekLabel       = UILabel()
    private let dayLabel        = UILabel()
    private let eventNameLabel  = UILabel()
    private let dateLabel        = UILabel()
    private let backgroundImage = UIImageView()
    private var verticalStack   = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [yearLabel, monthLabel, weekLabel, dayLabel,
         eventNameLabel, dateLabel, backgroundImage, verticalStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
         }
        
        [yearLabel, monthLabel, weekLabel, dayLabel, dateLabel].forEach {
            $0.font = .systemFont(ofSize: 22, weight: .medium)
            $0.textColor = .label
        }
        
        eventNameLabel.font      = .systemFont(ofSize: 28, weight: .bold)
        eventNameLabel.textColor = .label
        verticalStack.axis       = .vertical
        
        [yearLabel, monthLabel, weekLabel, dayLabel, dateLabel].forEach {
            verticalStack.addArrangedSubview($0)
        }
        
        addSubviews(backgroundImage, verticalStack)
    }
    
    private func setupLayout() {
        backgroundImage.pinToSuperviewEdges()
        verticalStack.pinToSuperviewEdges([.top, .right, .bottom], constant: 15)
        eventNameLabel.pinToSuperviewEdges([.left, .bottom], constant: 15)
    }
    
    func update(with viewModel: EventCellViewModel) {
        yearLabel.text        = viewModel.yearText
        monthLabel.text       = viewModel.monthText
        weekLabel.text        = viewModel.weakText
        dayLabel.text         = viewModel.dayText
        dateLabel.text        = viewModel.dateText
        eventNameLabel.text   = viewModel.eventText
        backgroundImage.image = viewModel.backgroundImage
    }
}
