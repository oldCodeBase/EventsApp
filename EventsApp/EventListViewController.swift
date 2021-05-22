//
//  EventListViewController.swift
//  EventsApp
//
//  Created by Ibragim Akaev on 22/05/2021.
//

import UIKit

final class EventListViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    private func setupVC() {
        title                = "Events"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .primary
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .plusImage,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(addTapped))
    }
    
    @objc private func addTapped() {
        print("Right bar button tapped")
    }
}
