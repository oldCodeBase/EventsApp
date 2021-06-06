//
//  EventDetailViewController.swift
//  EventsApp
//
//  Created by Ibragim Akaev on 03/06/2021.
//

import UIKit

final class EventDetailViewController: UIViewController {
    
    private let backgroundImage = UIImageView()
    private var timeRemainingStackView = TimeRemainingStackView()
    var viewModel: EventDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavController()
        updateViewModel()
        setupViews()
        setupLayout()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }
    
    private func setupNavController() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "pencil"),
                                                            style: .plain,
                                                            target: viewModel,
                                                            action: #selector(viewModel.editButtonTapped))
    }
    
    private func setupViews() {
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.contentMode = .scaleAspectFill
        view.addSubviews(backgroundImage)
        view.addSubviews(timeRemainingStackView)
    }
    
    private func setupLayout() {
        backgroundImage.pinToSuperviewEdges()
        timeRemainingStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        timeRemainingStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

    }
    
    private func updateViewModel() {
        viewModel.onUpdate = { [weak self] in
            guard let self = self,
                  let timeRemainingViewModel = self.viewModel.timeRemainingViewModel
            else { return }
            self.backgroundImage.image = self.viewModel.image
            self.timeRemainingStackView.update(with: timeRemainingViewModel)
            self.timeRemainingStackView.setup()
        }
        viewModel.viewDidLoad()
    }
}
