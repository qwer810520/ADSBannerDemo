//
//  CarouselBannerViewController.swift
//  ADSBannerDemo
//
//  Created by Min on 2021/8/3.
//

import UIKit

class CarouselBannerViewController: UIViewController {

  private var demoDatas: [Int] = [1, 2, 3]
  private var timer: Timer?

  lazy private var bannerView: CarouselBannerView = {
    return CarouselBannerView(delegate: self)
  }()

  // MARK: - UIViewController

  init() {
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupUserInterface()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    bannerView.scrollToFirstItem()

    startTimer()
  }

  // MARK: - Private Methods

  private func setupUserInterface() {
    view.addSubview(bannerView)
    view.translatesAutoresizingMaskIntoConstraints = false
    setupLayout()
  }

  private func setupLayout() {
    let views: [String: Any] = ["bannerView": bannerView]

    view.addConstraints(NSLayoutConstraint.constraints(
                          withVisualFormat: "H:|[bannerView]|",
                          options: [],
                          metrics: nil,
                          views: views))

    view.addConstraints(NSLayoutConstraint.constraints(
                          withVisualFormat: "V:|[bannerView]|",
                          options: [],
                          metrics: nil,
                          views: views))
  }
}

  // MARK: - CarouselBannerViewDelegate

extension CarouselBannerViewController: CarouselBannerViewDelegate {
  func stopTimer() {
    timer?.invalidate()
    timer = nil
  }

  func startTimer() {
    timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { [weak self] _ in
      self?.bannerView.scrollToNextItem()
    })
  }

  func numberOfDataCount() -> Int {
    return demoDatas.count + 2
  }

  func findData(with index: Int) -> String {
    let index = (index + 2) % demoDatas.count
    return String(demoDatas[index])
  }
}
