//
//  EventCell.swift
//  EventsApp
//
//  Created by Ibragim Akaev on 28/05/2021.
//

import UIKit

final class EventCell: UITableViewCell {
    private let timeRemainingLabels = [UILabel(), UILabel(), UILabel(), UILabel()]
    private let eventNameLabel      = UILabel()
    private let dateLabel           = UILabel()
    private let backgroundImage     = UIImageView()
    private var verticalStack       = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        (timeRemainingLabels + [eventNameLabel, dateLabel, backgroundImage, verticalStack]).forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        timeRemainingLabels.forEach {
            $0.font = .systemFont(ofSize: 22, weight: .medium)
            $0.textColor = .white
        }
        
        [dateLabel, eventNameLabel].forEach { $0.textColor = .white}
        dateLabel.font           = .systemFont(ofSize: 16, weight: .medium)
        eventNameLabel.font      = .systemFont(ofSize: 28, weight: .bold)
        verticalStack.axis       = .vertical
        verticalStack.alignment  = .trailing
        
        timeRemainingLabels.forEach { verticalStack.addArrangedSubview($0) }
        
        verticalStack.addArrangedSubview(UIView())
        verticalStack.addArrangedSubview(dateLabel)
        
        addSubviews(backgroundImage, verticalStack, eventNameLabel)
    }
    
    private func setupLayout() {
        backgroundImage.heightAnchor.constraint(equalToConstant: 250).isActive = true
        backgroundImage.pinToSuperviewEdges()
        verticalStack.pinToSuperviewEdges([.top, .right, .bottom], constant: 15)
        eventNameLabel.pinToSuperviewEdges([.left, .bottom], constant: 10)
    }
    
    func update(with viewModel: EventCellViewModel) {
        viewModel.timeRemaningStrings.enumerated().forEach {
            timeRemainingLabels[$0.offset].text = $0.element
        }
        dateLabel.text        = viewModel.dateText
        eventNameLabel.text   = viewModel.eventText
        viewModel.loadImage { backgroundImage.image = $0 }
    }
}
