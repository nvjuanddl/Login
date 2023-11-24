//
//  Describable.swift
//  Login
//
//  Created by Juan Delgado Lasso on 23/11/23.
//

import UIKit

protocol Describable {
    static var name: String { get }
}

extension Describable {
    static var name: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Describable { }

extension UICollectionReusableView: Describable { }

extension UITableViewHeaderFooterView: Describable { }
