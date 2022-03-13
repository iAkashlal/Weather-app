//
//  EmptyStateView.swift
//  Weather
//
//  Created by akashlal on 13/03/22.
//

import UIKit

protocol EmptyStateDelegate: AnyObject {
    func buttonDidTap(_ sender: UIButton)
}

final class EmptyStateView: UIView {

    weak var delegate: EmptyStateDelegate?

    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: Image.emptyResults)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    private let headlineLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let showAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("Go Random", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.masksToBounds = true
        button.backgroundColor = Color.darkText
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setup() {
        setupView()
        configureButton()
    }

    private func setupView() {
        let guide = safeAreaLayoutGuide
        self.backgroundColor = UIColor.white
        showAllButton.constrainHeight(constant: 48)
        logoImageView.constrainWidth(constant: 256)
        logoImageView.constrainHeight(constant: 200)
        stackView.addArrangedSubviews([logoImageView, headlineLabel, subtitleLabel])
        addSubviews(
            [
                stackView, showAllButton
            ]
        )
        stackView.anchor(
            top: nil,
            leading: guide.leadingAnchor,
            bottom: nil,
            trailing: guide.trailingAnchor,
            padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        )
        stackView.centerInSuperview()
        showAllButton.anchor(
            top: nil,
            leading: guide.leadingAnchor,
            bottom: guide.bottomAnchor,
            trailing: guide.trailingAnchor,
            padding: UIEdgeInsets(top: 10, left: 16, bottom: 30, right: 16)
        )
        setupFonts()
    }

    private func configureButton() {
        showAllButton.addTarget(
            self,
            action: #selector(showAllButtonDidTap(_:)),
            for: .touchUpInside
        )
    }

    public func configure(
        titleText: String,
        subtitleText: String,
        image: UIImage? = nil,
        buttonText: String? = nil
    ) {
        self.headlineLabel.text = titleText
        self.subtitleLabel.text = subtitleText
        if let image = image {
            self.logoImageView.image = image
        }
        if let buttonText = buttonText {
            self.showAllButton.setTitle(buttonText, for: .normal)
            self.showAllButton.isHidden = false
        } else {
            self.showAllButton.isHidden = true
        }
        
    }

    private func setupFonts() {
        headlineLabel.numberOfLines = 3
        subtitleLabel.numberOfLines = 4
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupFonts()
        showAllButton.roundCorners()
    }

    // MARK: - Button Actions

    @objc private func showAllButtonDidTap(_ sender: UIButton) {
        self.delegate?.buttonDidTap(sender)
    }
}

extension UIView {
    
    // Utilities to round view corners
    func roundCorners(radius: CGFloat? = nil) {
        layer.cornerRadius = radius ?? bounds.height / 2
    }
    
    @discardableResult
    func anchor(
        top: NSLayoutYAxisAnchor?,
        leading: NSLayoutXAxisAnchor?,
        bottom: NSLayoutYAxisAnchor?,
        trailing: NSLayoutXAxisAnchor?,
        padding: UIEdgeInsets = .zero,
        size: CGSize = .zero
    ) -> AnchoredConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()

        if let top = top {
            anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }

        if let leading = leading {
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }

        if let bottom = bottom {
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }

        if let trailing = trailing {
            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }

        if size.width != 0 {
            anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
        }

        if size.height != 0 {
            anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }

        [
            anchoredConstraints.top,
            anchoredConstraints.leading,
            anchoredConstraints.bottom,
            anchoredConstraints.trailing,
            anchoredConstraints.width,
            anchoredConstraints.height
        ].forEach { $0?.isActive = true }

        return anchoredConstraints
    }

    func fillSuperview(padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewTopAnchor = superview?.topAnchor {
            topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top).isActive = true
        }

        if let superviewBottomAnchor = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom).isActive = true
        }

        if let superviewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left).isActive = true
        }

        if let superviewTrailingAnchor = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right).isActive = true
        }
    }

    func centerInSuperview(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }

        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }

        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }

        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }

    func centerXInSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superViewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superViewCenterXAnchor).isActive = true
        }
    }

    func centerYInSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let centerY = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
    }

    func constrainWidth(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: constant).isActive = true
    }

    func constrainHeight(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: constant).isActive = true
    }

    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        layer.add(animation, forKey: nil)
    }

    func addSubviews(_ views: [UIView]) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
    }
}

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addArrangedSubview($0)
        }
    }

    func removeAllArrangedSubviews() {
        self.arrangedSubviews.forEach {
            self.removeArrangedSubview($0)
            self.removeFromSuperview()
        }
    }

    func removeArrangedSubviews(_ subviews: [UIView]) {
        subviews.forEach {
            self.removeArrangedSubview($0)
            self.removeFromSuperview()
        }
    }
}

struct AnchoredConstraints {
    var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}
