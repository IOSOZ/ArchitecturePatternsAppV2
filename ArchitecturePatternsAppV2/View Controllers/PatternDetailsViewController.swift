//
//  PatternDetailsViewController.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 24.09.2025.
//

import UIKit
import SnapKit

final class PatternDetailsViewController: UIViewController {
    
    // MARK: - UI Properties
    var patternNameLabel = UILabel()
    var descriptionLabel = UILabel()
    var patternImage = UIImageView()
    var favoriteButton = UIButton()
    
    // MARK: - Properties
    private var storeManager = StorageManager()
    var object: Pattern!
    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    // MARK: - View Setup
    private func setupView() {
        setupUI()
        setUpNavigationBar()
        addViews()
        setupConstraints()
    }
    
    // MARK: - Objc methods
    @objc func didTapFavoriteButton() {
        object?.isFavorite.toggle()
        print(object?.isFavorite as Any)
        if let favoriteButton = navigationItem.rightBarButtonItem?.customView as? UIButton {
            UIView.animate(withDuration: 0.3) {
                self.updateFavoriteButtonColor()
                favoriteButton.layoutIfNeeded()
            }
        }
    }
}

// MARK: - PatternDetailsViewController Extension
private extension PatternDetailsViewController {
    
    // MARK: - NavBar Setup
    func setUpNavigationBar() {
        navigationController?.navigationBar.tintColor = .black
        favoriteButton = UIButton(type: .system)
        favoriteButton.setImage(UIImage(resource: .like), for: .normal)
        
        updateFavoriteButtonColor()
        favoriteButton.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)
        favoriteButton.snp.makeConstraints { make in
            make.size.equalTo(24)
        }
        
        let rightButton = UIBarButtonItem(customView: favoriteButton)
        navigationItem.rightBarButtonItem = rightButton
    }
    
    // MARK: - UI Setup
    func setupUI() {
        patternImage.image = object?.image
        patternNameLabel.text = object?.name
        descriptionLabel.text = object?.description
        patternNameLabel.font = UIFont(name: "SFPro-Semibold", size: 24)
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont(name: "SFPro-Regular", size: 16)
        descriptionLabel.textColor = UIColor(resource: .sideMenu)
        descriptionLabel.textAlignment = .left
        
        self.view.backgroundColor = UIColor.systemBackground
    }
    
    // MARK: - Add Views
    func addViews() {
        view.addSubview(patternImage)
        view.addSubview(descriptionLabel)
        view.addSubview(patternNameLabel)
    }
    
    // MARK: - Constraints Setup
    func setupConstraints() {
        patternImage.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(100)
        }
        
        patternNameLabel.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(16)
            make.top.equalTo(patternImage.snp.bottom).offset(20)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(patternNameLabel.snp.bottom).offset(20)
        }
    }
    
    // MARK: - Private Methods
    func updateFavoriteButtonColor() {
        switch object?.isFavorite {
        case true:
            favoriteButton.tintColor = .red
        default:
            favoriteButton.tintColor = UIColor(resource: .sideMenu)
        }
        storeManager.updatePattern(object)
    }
}
