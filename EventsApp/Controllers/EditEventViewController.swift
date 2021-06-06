//
//  EditEventViewController.swift
//  EventsApp
//
//  Created by Ibragim Akaev on 06/06/2021.
//

import UIKit

final class EditEventViewController: UIViewController {
    private let tableView = UITableView()
    var viewModel: EditEventViewModel!
    
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
extension EditEventViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = viewModel.cell(for: indexPath)
        switch cellViewModel {
        case .titleSubtitle(let editEventCellViewModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewEventCellID", for: indexPath) as! NewEventCell
            cell.update(with: editEventCellViewModel)
            cell.subtitleTextField.delegate = self
            return cell
        }
    }
}

//MARK: - UITableViewDataSource
extension EditEventViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - UITextFieldDelegate
extension EditEventViewController: UITextFieldDelegate {
    
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

