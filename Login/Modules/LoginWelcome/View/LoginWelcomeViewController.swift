//
//  LoginWelcomeViewController.swift
//  Login
//
//  Created by Juan Delgado Lasso on 23/11/23.
//
//

import UIKit

final class LoginWelcomeViewController: UIViewController {
    
    // MARK: - Private properties -
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 50.0
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.register(DescriptionTableViewCell.self, forCellReuseIdentifier: DescriptionTableViewCell.name)
        return tableView
    }()
    
    private lazy var header: UILabel = {
        let header = UILabel()
        header.backgroundColor = .green
        header.numberOfLines = 0
        header.text = "Welcome"
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
    
    // MARK: - Public properties -
    
    var presenter: LoginWelcomePresenterInterface!
    
    // MARK: - Lifecycle -
    
    override func loadView() {
        super.loadView()
        addSubviews()
        configureConstraints()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    // MARK: - Private methods -
    
    private func addSubviews() {
        view.addSubview(header)
        view.addSubview(tableView)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            header.leftAnchor.constraint(equalTo: view.leftAnchor),
            header.rightAnchor.constraint(equalTo: view.rightAnchor),
            header.heightAnchor.constraint(equalToConstant: 60),
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.topAnchor.constraint(equalTo: header.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource -

extension LoginWelcomeViewController: UITableViewDelegate, UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionTableViewCell.name, for: indexPath) as! DescriptionTableViewCell
        cell.config(with: presenter.items[indexPath.row])
        return cell
    }
}

// MARK: - LoginWelcomeViewInterface -

extension LoginWelcomeViewController: LoginWelcomeViewInterface {
    
    func reloadView() {
        tableView.reloadData()
    }
}
