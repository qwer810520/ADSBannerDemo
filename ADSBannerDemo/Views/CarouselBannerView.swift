//
//  CarouselBannerView.swift
//  ADSBannerDemo
//
//  Created by Min on 2021/8/3.
//

import UIKit

class CarouselBannerView: UIView {

  private var datas: [String] = ["1", "2", "3"]

  lazy private var flowLayout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    return layout
  }()

  lazy private var collectionView: UICollectionView = {
    let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.delegate = self
    view.dataSource = self
    view.register(DemoCell.self, forCellWithReuseIdentifier: DemoCell.identifier)
    view.backgroundColor = .darkGray
    view.isPagingEnabled = true
    view.showsHorizontalScrollIndicator = false
    return view
  }()

  // MARK: - Initialization

  init() {
    super.init(frame: .zero)
    setupUserInterface()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Private Methods

  private func setupUserInterface() {
    translatesAutoresizingMaskIntoConstraints = false
    addSubview(collectionView)

    setupLayout()
  }

  private func setupLayout() {
    let views: [String: Any] = ["collectionView": collectionView]

    addConstraints(NSLayoutConstraint.constraints(
                    withVisualFormat: "H:|[collectionView]|",
                    options: [],
                    metrics: nil,
                    views: views))

    addConstraints(NSLayoutConstraint.constraints(
                    withVisualFormat: "V:|[collectionView]|",
                    options: [],
                    metrics: nil,
                    views: views))
  }
}

  // MARK: - UICollectionViewDelegateFlowLayout

extension CarouselBannerView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: collectionView.frame.width, height: collectionView.frame.height)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}

  // MARK: - UICollectionViewDataSource

extension CarouselBannerView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return datas.count + 2
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DemoCell.identifier, for: indexPath) as? DemoCell else {
      fatalError("Cell init failure")
    }

    let index = (indexPath.item + 2) % datas.count
    cell.title = datas[index]
    return cell
  }
}

  // MARK: - UIView Extension

extension UIView {
  func addSubviews(_ views: [UIView]) {
    views.forEach { addSubview($0) }
  }
}
