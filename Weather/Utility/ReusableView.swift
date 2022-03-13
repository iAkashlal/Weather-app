//
//  ReusableView.swift
//  Weather
//
//  Created by akashial on 13/03/22.
//

import UIKit

///    Adopt this protocol on all subclasses of UITableViewCell and UICollectionViewCell
///    that use their own .xib file
public protocol NibLoadableView {
    ///    By default, it returns the subclass name
    static var nibName: String { get }

    ///    Instantiates UINib using `nibName` as the name, from the main bundle
    static var nib: UINib { get }
}

public extension NibLoadableView where Self: UIView {
    static var nibName: String {
        String(describing: self)
    }

    static var nib: UINib {
        UINib(nibName: nibName, bundle: nil)
    }
}


///    Protocol to allow any UIView to become reusable view
public protocol ReusableView {
    ///    By default, it returns the subclass name
    static var reuseIdentifier: String { get }
}

public extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}


public protocol NibReusableView: ReusableView, NibLoadableView {}

extension UITableViewHeaderFooterView: NibReusableView {}
extension UITableViewCell: NibReusableView {}

