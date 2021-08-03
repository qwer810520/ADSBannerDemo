//
//  DemoViewController.swift
//  ADSBannerDemo
//
//  Created by Min on 2021/8/3.
//

import UIKit

class DemoViewController: UIViewController {

  lazy private var adsBannerView: CarouselBannerViewController = {
    return CarouselBannerViewController()
  }()

  // MARK: - UIViewController

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupUserInterface()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }

  // MARK: - Private Methods

  private func setupUserInterface() {
    title = "BannerDemo"
    view.backgroundColor = .white
    addChild(adsBannerView)
    view.addSubview(adsBannerView.view)

    setupLayout()
  }

  private func setupLayout() {
    NSLayoutConstraint.activate([
      adsBannerView.view.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 5),
      adsBannerView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      adsBannerView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      adsBannerView.view.heightAnchor.constraint(equalToConstant: 200)
    ])
  }
}
