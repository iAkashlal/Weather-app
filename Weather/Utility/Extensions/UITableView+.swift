//
//  UITableView+.swift
//  Weather
//
//  Created by akashlal on 13/03/22.
//

import UIKit

public extension UITableView {
    //    register for the Class-based cell
    func register<T: UITableViewCell>(class _: T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }

    //    register for the Nib-based cell
    func register<T: UITableViewCell>(nib _: T.Type) {
        register(T.nib, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Dequeing a cell with identifier: \(T.reuseIdentifier) failed.")
        }
        return cell
    }

    //    register for the Class-based header/footer view
    func register<T: UITableViewHeaderFooterView>(class _: T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }

    //    register for the Nib-based header/footer view
    func register<T: UITableViewHeaderFooterView>(nib _: T.Type) {
        register(T.nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableView<T: UITableViewHeaderFooterView>() -> T? {
        let view = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T
        return view
    }

    func dequeueReusableView<T: UITableViewHeaderFooterView>(type _: T.Type) -> T? {
        let view = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T
        return view
    }
}
