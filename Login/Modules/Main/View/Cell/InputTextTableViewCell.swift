//
//  InputTextTableViewCell.swift
//  Login
//
//  Created by Juan Delgado Lasso on 23/11/23.
//
//

import UIKit

class InputTextTableViewCell: UITableViewCell {
    
    // MARK: - Private properties -
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .left
        return textField
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Lifecycle -
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textField.tag = .zero
        textField.text = nil
        textField.placeholder = nil
    }
    
    // MARK: - Private methods -
    
    private func addSubviews() {
        contentView.backgroundColor = .white
        contentView.isUserInteractionEnabled = false
        addSubview(containerView)
        containerView.addSubview(textField)
        containerView.addSubview(lineView)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            containerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            containerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
            textField.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            textField.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            textField.topAnchor.constraint(equalTo: containerView.topAnchor),
            textField.bottomAnchor.constraint(equalTo: lineView.topAnchor),
            textField.heightAnchor.constraint(equalToConstant: 50),
            
            lineView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            lineView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            lineView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 3)
        ])
    }
    
    // MARK: - Public methods -
    
    func config(with placeholder: String?, tag: Int) {
        textField.placeholder = placeholder
        textField.tag = tag
    }
}
