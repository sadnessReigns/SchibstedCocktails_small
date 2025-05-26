//
//  CocktailListViewController.swift
//  SchibstedCocktails2
//
//  Created by Uladzislau Makei on 25.05.25.
//


import UIKit
import Combine

final class CocktailListViewController: UIViewController {

    // MARK: - Data

    private let viewModel: CocktailListViewModel
    private var errorCancellable: AnyCancellable?

    // MARK: - Subviews

    private let tableView = UITableView()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cocktails"
        view.backgroundColor = .systemBackground
        setupTableView()
        setupDataFlow()

        Task { [weak viewModel] in
            await viewModel?.loadData { [weak tableView] in
                DispatchQueue.main.async {
                    tableView?.reloadData()
                }
            }
        }
    }

    // MARK: - Init

    init(viewModel: CocktailListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - Setup

private extension CocktailListViewController {

    func setupDataFlow() {
        errorCancellable = viewModel.$error
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                guard let error else { return }

                self?.showError(error)
            }
    }

    func setupTableView() {
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.dataSource = self
        tableView.register(CocktailCell.self, forCellReuseIdentifier: "cell")
        tableView.allowsSelection = false
        view.addSubview(tableView)
    }


    func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

}

// MARK: - UITableViewDataSource

extension CocktailListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cocktails.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CocktailCell
        cell.configure(with: viewModel.cocktails[indexPath.row])
        return cell
    }
}
