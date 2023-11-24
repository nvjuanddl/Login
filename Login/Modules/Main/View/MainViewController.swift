//
//  MainViewController.swift
//  Login
//
//  Created by Juan Delgado Lasso on 23/11/23.
//

import UIKit

class MainViewController: UIViewController, MainViewInterface {
    
    // MARK: - Public properties -
    
    var presenter: MainPresenterInterface!

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
        tableView.register(InputTextTableViewCell.self, forCellReuseIdentifier: InputTextTableViewCell.name)
        return tableView
    }()
    
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.backgroundColor = .clear
        stack.spacing = .zero
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .green
        button.setTitle("LOG IN", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.isSelected = true
        button.addTarget(self, action: #selector(logIn(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("SIGN UP", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(signUp(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .green
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("SIGN IN", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(goToLoginWelcome(_:)), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle -
    
    override func loadView() {
        super.loadView()
        addSubviews()
        configureConstraints()
        reloadView()
    }

    // MARK: - Private methods -
    
    private func addSubviews() {
        view.addSubview(contentStack)
        view.addSubview(tableView)
        view.addSubview(continueButton)
        contentStack.addArrangedSubview(logInButton)
        contentStack.addArrangedSubview(signUpButton)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            contentStack.leftAnchor.constraint(equalTo: view.leftAnchor),
            contentStack.rightAnchor.constraint(equalTo: view.rightAnchor),
            contentStack.heightAnchor.constraint(equalToConstant: 60),
            contentStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.topAnchor.constraint(equalTo: contentStack.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: continueButton.topAnchor),
            
            continueButton.rightAnchor.constraint(equalTo: view.rightAnchor),
            continueButton.leftAnchor.constraint(equalTo: view.leftAnchor),
            continueButton.heightAnchor.constraint(equalToConstant: 60),
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func reloadView() {
        presenter.cleanData()
        tableView.reloadData()
        print(tableView.subviews)
    }
    
    @objc private func logIn(_ sender: UIButton) {
        logInButton.backgroundColor = .green
        signUpButton.backgroundColor = .white
        logInButton.isSelected = true
        signUpButton.isSelected = false
        continueButton.setTitle("SIGN IN", for: .normal)
        reloadView()
    }
    
    @objc private func signUp(_ sender: UIButton) {
        signUpButton.backgroundColor = .green
        logInButton.backgroundColor = .white
        signUpButton.isSelected = true
        logInButton.isSelected = false
        continueButton.setTitle("CREATE ACCOUNT", for: .normal)
        reloadView()
    }
    
    @objc private func goToLoginWelcome(_ sender: UIButton) {
        presenter.getItems(at: logInButton.isSelected ? .signIn : .signUp).forEach { type in
            if let textField = tableView.viewWithTag(type.rawValue) as? UITextField {
                presenter.checkTextField(tag: type.rawValue, fieldValue: textField.text)
            }
        }
        presenter.goToLoginWelcomeIfPossible(at: logInButton.isSelected ? .signIn : .signUp)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource -

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getNumberOfItem(at: logInButton.isSelected ? .signIn : .signUp)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InputTextTableViewCell.name, for: indexPath) as! InputTextTableViewCell
        let item = presenter.getItem(with: indexPath, at: logInButton.isSelected ? .signIn : .signUp)
        cell.textField.delegate = self
        cell.config(with: item.placeholder, tag: item.tag)
        return cell
    }
}

// MARK: - UITextFieldDelegate -

extension MainViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return presenter.shouldAcceptInput(tag: textField.tag, fieldValue: textField.text, input: string)
    }
}
