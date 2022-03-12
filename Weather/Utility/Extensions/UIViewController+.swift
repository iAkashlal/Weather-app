//
//  UIViewController+.swift
//  Weather
//
//  Created by akashlal on 12/03/22.
//

import Foundation
import UIKit

extension UIViewController {
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            T(nibName: String(describing: T.self), bundle: nil)
        }

        return instantiateFromNib()
    }
}
