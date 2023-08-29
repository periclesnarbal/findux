//
//  UINavigationControllerExtension.swift
//  findux
//
//  Created by Péricles Narbal on 02/08/23.
//

import UIKit

extension UINavigationController {
    func backToViewControllerBy<T: UIViewController>(type: T.Type) throws {
        do {
            let viewController = try findViewControllerBy(type: type)
            popToViewController(viewController, animated: true)
        } catch {
            throw error
        }
    }
    
    func findViewControllerBy<T: UIViewController>(type: T.Type) throws -> T {
        guard let foundViewController = viewControllers.first(where: { $0.isKind(of: type) }) as? T else {
            throw NSError(domain: "View Controller is not found", code: 0)
        }
        return foundViewController
    }
}
