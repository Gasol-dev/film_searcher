//
//  ViewController.swift
//  FilmSearcher
//
//  Created by Alexander Lezya on 22.05.2023.
//

import UIKit
import SnapKit
import ReSwift
import ReactiveKit
import ServiceModule

// MARK: - ViewController

final class MainViewController: UIViewController, StoreSubscriber {
    
    // MARK: - Aliases
    
    typealias StoreSubscriberStateType = MainState
    
    // MARK: - Properties
    
    /// Table view instance
    private let tableView = UITableView()
    
    /// Film models
    private var filmModels: [FilmCellViewModelProtocol] = []
    
    /// TextField instance
    private let textField = UITextField()
    
    /// DisposeBag instance
    private let disposeBag = DisposeBag()
    
    /// Search service
    private let searchService: ServiceProtocol
    
    /// Activity indicator
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    /// Not found label
    private let notFoundLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.notFoundText
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.isHidden = true
        return label
    }()
    
    private var disposableSearch: Disposable?
    
    // MARK: - Initializers
    
    init(filmModels: [FilmCellViewModelProtocol], searchService: ServiceProtocol) {
        self.filmModels = filmModels
        self.searchService = searchService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    }
    
    private func makeSearchSignal(with text: String) {
        disposableSearch?.dispose()
        activityIndicator.startAnimating()
        let searchSignal = searchService
            .searchFilms(with: APIConstants.token, name: text)
            .delay(interval: 1)
            .subscribe(on: ExecutionContext.global(qos: .userInitiated))
            .receive(on: ExecutionContext.main)
        disposableSearch = searchSignal
            .observeNext { [weak self] films in
                self?.filmModels = films.map {
                    FilmCellViewModel(
                        filmName: $0.name,
                        imageURL: URL(string: $0.posterUrlPreview)
                    )
                }
                self?.tableView.reloadData()
                self?.notFoundLabel.isHidden = !(self?.filmModels.isEmpty ?? false)
                self?.activityIndicator.stopAnimating()
            }
        disposableSearch?
            .dispose(in: disposeBag)
    }
    
    private func resetTable() {
        filmModels = []
        disposableSearch?.dispose()
        tableView.reloadData()
        activityIndicator.stopAnimating()
    }
}

// MARK: - Setup

private extension MainViewController {
    
    func setup() {
        setupTextField()
        setupTableView()
        setupActivityIndicator()
        setupNotFoundLabel()
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
    }
    
    func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make
                .center
                .equalToSuperview()
        }
    }
    
    func setupNotFoundLabel() {
        tableView.addSubview(notFoundLabel)
        notFoundLabel.snp.makeConstraints { make in
            make
                .center
                .equalTo(view)
        }
    }
}

// MARK: - Actions

extension MainViewController {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if text == "" {
            resetTable()
        } else {
            makeSearchSignal(with: text)
        }
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: Constants.cellName, for: indexPath)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filmModels.count
    }
}

// MARK: - UITableViewDelegateку

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? FilmCell else { return }
        cell.setup(with: filmModels[indexPath.item])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

// MARK: - Constants

extension MainViewController {
    
    enum Constants {
        static let cellName = "filmCell"
        static let notFoundText = "Фильмы не найдены"
    }
}
