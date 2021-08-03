//
//  CarouselBannerViewController.swift
//  ADSBannerDemo
//
//  Created by Min on 2021/8/3.
//

import UIKit

class CarouselBannerViewController: UIViewController {

  lazy private var bannerView: CarouselBannerView = {
    return CarouselBannerView()
  }()

  // MARK: - UIViewController

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupUserInterface()
  }

  // MARK: - Private Methods

  private func setupUserInterface() {
    title = "BannerDemo"
    view.backgroundColor = .white
    view.addSubview(bannerView)

    setupLayout()
  }

  private func setupLayout() {
    NSLayoutConstraint.activate([
      bannerView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 5),
      bannerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      bannerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      bannerView.heightAnchor.constraint(equalToConstant: 200)
    ])
  }
}
