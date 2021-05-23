//
//  NewEventCell.swift
//  EventsApp
//
//  Created by Ibragim Akaev on 23/05/2021.
//

import UIKit

final class NewEventCell: UITableViewCell {
    
    let subtitleTextField         = UITextField()
    private let toolBar           = UIToolbar(frame: .init(x: 0, y: 0, width: 100, height: 40))
    private let titleLabel        = UILabel()
    private let datePickerView    = UIDatePicker()
    private let verticalStackView = UIStackView()
    private let backgroundImage   = UIImageView()
    private let constant: CGFloat = 15
    private var viewModel: NewEventCellViewModel?
    lazy var doneButton: UIBarButtonItem = {
        UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tappedDone))
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        verticalStackView.axis             = .vertical
        titleLabel.font                    = UIFont.systemFont(ofSize: 22, weight: .medium)
        subtitleTextField.font             = UIFont.systemFont(ofSize: 20, weight: .medium)
        datePickerView.datePickerMode      = .date
        backgroundImage.backgroundColor    = .secondaryLabel
        backgroundImage.layer.cornerRadius = 10
        toolBar.setItems([doneButton], animated: true)
        datePickerView.preferredDatePickerStyle = .wheels
        
        [verticalStackView, titleLabel, subtitleTextField].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupLayout() {
        contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(backgroundImage)
        verticalStackView.addArrangedSubview(subtitleTextField)
        
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: constant),
            verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: constant),
            verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -constant),
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -constant),
            
            backgroundImage.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func update(with viewModel: NewEventCellViewModel) {
        self.viewModel                       = viewModel
        titleLabel.text                      = viewModel.title
        subtitleTextField.text               = viewModel.subtitle
        subtitleTextField.placeholder        = viewModel.placeholder
        backgroundImage.isHidden             = viewModel.cellType != .image
        backgroundImage.image                = viewModel.image
        subtitleTextField.isHidden           = viewModel.cellType == .image
        subtitleTextField.inputView          = viewModel.cellType == .text ? nil : datePickerView
        subtitleTextField.inputAccessoryView = viewModel.cellType == .text ? nil : toolBar
        verticalStackView.spacing            = viewModel.cellType == .image ? 15 : verticalStackView.spacing
    }
    
    @objc private func tappedDone() {
        viewModel?.update(datePickerView.date)
    }
}
