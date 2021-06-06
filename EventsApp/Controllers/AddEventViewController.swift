//
//  AddEventViewController.swift
//  EventsApp
//
//  Created by Ibragim Akaev on 23/05/2021.
//

import UIKit

final class AddEventViewController: UIViewController {
    
    private let tableView = UITableView()
    var viewModel: AddEventViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVC()
        setupTableView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }
    
    private func setupVC() {
        view.backgroundColor = .systemBackground
        viewModel.onUpdate = { [weak self] in self?.tableView.reloadData() }
        viewModel.viewDidLoad()
        navigationItem.title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .label
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                            target: self,
                                                            action: #selector(tappedDone))
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame           = view.bounds
        tableView.delegate        = self
        tableView.dataSource      = self
        tableView.tableFooterView = UIView()
        tableView.register(NewEventCell.self, forCellReuseIdentifier: "NewEventCellID")
    }
    
    @objc private func tappedDone() {
        viewModel.tappedDone()
    }
}

//MARK: - UITableViewDelegate
extension AddEventViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = viewModel.cell(for: indexPath)
        switch cellViewModel {
        case .titleSubtitle(let addEventCellViewModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewEventCellID", for: indexPath) as! NewEventCell
            cell.update(with: addEventCellViewModel)
            cell.subtitleTextField.delegate = self
            return cell
        }
    }
}

//MARK: - UITableViewDataSource
extension AddEventViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - UITextFieldDelegate
extension AddEventViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return false }
        let text = currentText + string
        let point = textField.convert(textField.bounds.origin, to: tableView)
        if let indexPath = tableView.indexPathForRow(at: point) {
            viewModel.updateCell(indexPath: indexPath, subtitle: text)
        }
        
        return true
    }
}
