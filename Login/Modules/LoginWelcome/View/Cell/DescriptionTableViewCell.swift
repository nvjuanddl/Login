//
//  DescriptionTableViewCell.swift
//  Login
//
//  Created by Juan Delgado Lasso on 24/11/23.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {
    
    // MARK: - Private properties -
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        label.text = nil
    }
    
    // MARK: - Private methods -
    
    private func addSubviews() {
        contentView.backgroundColor = .white
        addSubview(containerView)
        containerView.addSubview(label)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            containerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            containerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
            label.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            label.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            label.topAnchor.constraint(equalTo: containerView.topAnchor),
            label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            label.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // MARK: - Public methods -
    
    func config(with text: String?) {
        label.text = text
    }
}
