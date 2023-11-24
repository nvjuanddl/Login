//
//  BaseWireframe.swift
//  Login
//
//  Created by Juan Delgado Lasso on 23/11/23.
//
//

import UIKit

protocol WireframeInterface: AnyObject {
    func dismiss(animated: Bool)
    func showAlert(alertViewModel: AlertViewModel)
}

class BaseWireframe {

    private unowned var _viewController: UIViewController

    private var _temporaryStoredViewController: UIViewController?

    init(viewController: UIViewController) {
        _temporaryStoredViewController = viewController
        _viewController = viewController
    } 
}

extension BaseWireframe: WireframeInterface {
    
    var viewController: UIViewController {
        defer { _temporaryStoredViewController = nil }
        return _viewController
    }

    var navigationController: UINavigationController? {
        return viewController.navigationController
    }
    
    func popFromNavigationController(animated: Bool) {
        let _ = navigationController?.popViewController(animated: animated)
    }
    
    func dismiss(animated: Bool) {
        navigationController?.dismiss(animated: animated)
    }
    
    func showAlert(alertViewModel: AlertViewModel) {
        let actionAlertAction = UIAlertController(alertViewModel.title,
                                                  alertViewModel.message,
                                                  alertViewModel.dismissActionTitle)
        viewController.present(actionAlertAction, animated: true, completion: nil)
    }
}

extension UIViewController {

    func presentWireframe(_ wireframe: BaseWireframe, animated: Bool = true, completion: (() -> Void)? = nil) {
        present(wireframe.viewController, animated: animated, completion: completion)
    }
}

extension UIAlertController {
    
    public convenience init(
        _ title: String,
        _ message: String,
        _ dismissActionTitle: String
    ) {
        self.init(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: dismissActionTitle, style: .default, handler: nil)
        addAction(dismissAction)
    }

}

extension UINavigationController {

    func pushWireframe(_ wireframe: BaseWireframe, animated: Bool = true) {
        self.pushViewController(wireframe.viewController, animated: animated)
    }

    func setRootWireframe(_ wireframe: BaseWireframe, animated: Bool = true) {
        self.setViewControllers([wireframe.viewController], animated: animated)
    }

    func popViewController(animated: Bool, callback: (() -> Void)?) {
        popViewController(animated: animated)
        if let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
               callback?()
            }
        } else {
            callback?()
        }
    }
}
