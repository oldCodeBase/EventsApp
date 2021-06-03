//
//  EventDetailViewController.swift
//  EventsApp
//
//  Created by Ibragim Akaev on 03/06/2021.
//

import UIKit

final class EventDetailViewController: UIViewController {
    
    private let backgroundImage = UIImageView()
    var viewModel: EventDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.onUpdate = { [weak self] in self?.backgroundImage.image = self?.viewModel.image }
        viewModel.viewDidLoad()
        setupViews()
        setupLayout()
    }
    
    private func setupViews() {
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.contentMode = .scaleAspectFill
        view.addSubviews(backgroundImage)
    }
    
    private func setupLayout() {
        backgroundImage.pinToSuperviewEdges()
    }
}
