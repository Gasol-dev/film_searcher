//
//  ViewController.swift
//  FilmSearcher
//
//  Created by Alexander Lezya on 22.05.2023.
//

import UIKit
import SnapKit
import ReSwift

// MARK: - ViewController

final class MainViewController: UIViewController, StoreSubscriber {
    
    // MARK: - Aliases
    
    typealias StoreSubscriberStateType = MainState
    
    // MARK: - Properties
    
    /// Table view instance
    private let tableView = UITableView()
    
    /// TextField instance
    private let textField = UITextField()
    
    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FilmCell.self, forCellReuseIdentifier: Constants.cellName)
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mainStore.subscribe(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        mainStore.unsubscribe(self)
    }

    // MARK: - Useful
    
    func newState(state: MainState) {
        tableView.reloadData()
    }
}

// MARK: - Setup

private extension MainViewController {
    
    func setup() {
        setupTextField()
        setupTableView()
    }
    
    func setupTextField() {
        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make
                .top
                .equalTo(view.safeAreaLayoutGuide.snp.top)
            make
                .leading
                .equalToSuperview()
                .offset(24)
            make
                .trailing
                .equalToSuperview()
                .offset(-24)
            make.height.equalTo(45)
        }
        textField.layer.cornerRadius = 13
        textField.backgroundColor = .gray.withAlphaComponent(0.2)
        textField.placeholder = "Search"
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make
                .top
                .equalTo(textField.snp.bottom)
                .offset(16)
            make
                .leading
                .trailing
                .bottom
                .equalToSuperview()
        }
        tableView.backgroundColor = .yellow
    }
}

// MARK: - Actions

extension MainViewController {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        mainStore
            .dispatch(SearchAction(targetName: text))
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: Constants.cellName, for: indexPath)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mainStore.state.filmModels.count
    }
}

// MARK: - UITableViewDelegateку

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? FilmCell else { return }
        cell.setup(with: mainStore.state.filmModels[indexPath.item])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.cellHeight
    }
}

// MARK: - Constants

extension MainViewController {
    
    enum Constants {
        static let cellName = "filmCell"
        static let cellHeight: CGFloat = 45
    }
}
