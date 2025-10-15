//
//  ImageViewerViewController.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 15.10.2025.
//

import UIKit
import SnapKit

final class ImageViewerViewController: UIViewController {

    // MARK: - UI Properties
    private let scrollView = UIScrollView()
    private let imageView = UIImageView()
    private let image: UIImage

    // MARK: - Initialization
    init(image: UIImage) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - Private Methods
private extension ImageViewerViewController {
    
    // MARK: - Setup UI
    func setupView() {
        setupUI()
        addViews()
        setupConstraints()
        setupGesture()
        centringImage()
    }
    
    // MARK: - Setup UI
    func setupUI() {
        view.backgroundColor = .systemBackground
        
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 4
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        
    }
    
    // MARK: - Add Views
    func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
    }
    
    // MARK: - Setup Constraints
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(view.snp.width)
            make.height.equalTo(view.snp.height)
        }
    }
    
    func centringImage() {
        let offsetX = max((scrollView.bounds.width - scrollView.contentSize.width) * 0.5, 0)
        let offsetY = max((scrollView.bounds.height - scrollView.contentSize.height) * 0.5, 0)

        imageView.center = CGPoint(
            x: scrollView.contentSize.width * 0.5 + offsetX,
            y: scrollView.contentSize.height * 0.5 + offsetY
        )
    }
    
    // MARK: - Gesture Setup
    func setupGesture() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_ :)))
        doubleTap.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTap)
    }
    
    // MARK: - OBJC Methods
    @objc func handleDoubleTap(_ sender: UITapGestureRecognizer) {
        if scrollView.zoomScale == 1 {
            scrollView.setZoomScale(2, animated: true)
        } else {
            scrollView.setZoomScale(1, animated: true)
        }
    }
}

extension ImageViewerViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centringImage()
    }
}
