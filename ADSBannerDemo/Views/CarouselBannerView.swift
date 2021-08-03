//
//  CarouselBannerView.swift
//  ADSBannerDemo
//
//  Created by Min on 2021/8/3.
//

import UIKit

protocol CarouselBannerViewDelegate: class {
  func numberOfDataCount() -> Int
  func findData(with index: Int) -> String
}

class CarouselBannerView: UIView {

  lazy private var pageControl: UIPageControl = {
    let view = UIPageControl()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

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
    view.backgroundColor = .darkGray
    view.isPagingEnabled = true
    view.showsHorizontalScrollIndicator = false
    view.register(DemoCell.self, forCellWithReuseIdentifier: DemoCell.identifier)
    return view
  }()

  weak var delegate: CarouselBannerViewDelegate?

  var dataCount: Int {
    return delegate?.numberOfDataCount() ?? 0
  }

  // MARK: - Initialization

  init(delegate: CarouselBannerViewDelegate? = nil) {
    self.delegate = delegate
    super.init(frame: .zero)
    setupUserInterface()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func scrollToFirstItem() {
    scrollToItem(with: 1)
    pageControl.currentPage = 0
  }

  // MARK: - Private Methods

  private func setupUserInterface() {
    translatesAutoresizingMaskIntoConstraints = false
    addSubviews([collectionView, pageControl])

    setupLayout()
    setupPageControl()
  }

  private func setupLayout() {
    let views: [String: Any] = ["collectionView": collectionView, "pageControl": pageControl]

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

    addConstraints(NSLayoutConstraint.constraints(
                    withVisualFormat: "H:|[pageControl]|",
                    options: [],
                    metrics: nil,
                    views: views))

    addConstraints(NSLayoutConstraint.constraints(
                    withVisualFormat: "V:[pageControl(height)]-bottomSpace-|",
                    options: [],
                    metrics: ["bottomSpace": 5, "height": 30],
                    views: views))
  }

  private func setupPageControl() {
    pageControl.numberOfPages = max(0, dataCount - 2)
    pageControl.currentPage = 0
  }

  private func scrollToItem(with item: Int) {
    guard let point = collectionView.layoutAttributesForItem(at: .init(item: item, section: 0))?.frame.origin else { return }
    collectionView.setContentOffset(point, animated: false)
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
}

  // MARK: - UICollectionViewDataSource

extension CarouselBannerView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return dataCount + 2
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    print(#function)
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DemoCell.identifier, for: indexPath) as? DemoCell else {
      fatalError("Cell init failure")
    }
    cell.title = delegate?.findData(with: indexPath.item)
    return cell
  }
}

  // MARK: - UIView Extension

extension UIView {
  func addSubviews(_ views: [UIView]) {
    views.forEach { addSubview($0) }
  }
}
