//
//  DemoCell.swift
//  ADSBannerDemo
//
//  Created by Min on 2021/8/3.
//

import UIKit

class DemoCell: UICollectionViewCell {

  var title: String? {
    didSet {
      guard let title = title else { return }

      titleLable.text = title

      var backgroundColor: UIColor = .clear
      switch title {
        case "1":
          backgroundColor = .systemRed
        case "2":
          backgroundColor = .systemGreen
        case "3":
          backgroundColor = .systemBlue
        default: break
      }

      contentView.backgroundColor = backgroundColor
    }
  }

  lazy private var titleLable: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.boldSystemFont(ofSize: 70)
    label.textColor = .white
    label.textAlignment = .center
    return label
  }()

  // MARK: - Initialization

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUserInterface()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Private Methods

  private func setupUserInterface() {
    contentView.addSubview(titleLable)

    setupLayout()
  }

  private func setupLayout() {
    let views: [String: Any] = ["titleLable": titleLable]

    contentView.addConstraints(NSLayoutConstraint.constraints(
                                withVisualFormat: "H:|[titleLable]|",
                                options: [],
                                metrics: nil,
                                views: views))

    contentView.addConstraints(NSLayoutConstraint.constraints(
                                withVisualFormat: "V:|[titleLable]|",
                                options: [],
                                metrics: nil,
                                views: views))
  }
}

extension UICollectionReusableView {
  static var identifier: String {
    return String(describing: self)
  }
}
