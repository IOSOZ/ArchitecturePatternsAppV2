//
//  OOPViewController.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 04.10.2025.
//

import UIKit

class OOPViewController: BaseContentViewController {
    
    
    // MARK: - Clean Swift
    var router: EmptyRouter?
    private let seedUpLoader = SeedLoader()
    
    // MARK: - UI Properties
    let technicalWorkImage = UIImageView(image: UIImage(resource: .technicalWork))
    let textLabel = UILabel()
    
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @objc override func didTapRightButton() {
        router?.toggleSideMenu()
    }
    
    @objc func handleTripleTap() {
        let alert = UIAlertController(
            title: "Reset remote DB?",
            message: "Все удалённые паттерны будут стерты и заменены сидовыми.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        alert.addAction(UIAlertAction(title: "Сбросить", style: .destructive) { [weak self] _ in
            self?.performRemoteReset()
        })
        present(alert, animated: true)
    }
}

// MARK: - OOPViewController Extension
private extension OOPViewController {
    
    // MARK: - Setup View
    func setupView() {
        setupUI()
        addViews()
        setupConstraints()
        setupTripleTapReset()
    }
    
    
    
    // MARK: - Setup UI
    func setupUI() {
        view.backgroundColor = .white
        self.navigationItem.leftBarButtonItem = nil
        title = "Принципы ООП"
        
        textLabel.font = UIFont(name: "SFPro-Regular", size: 20)
        textLabel.text = "Ведутся технические работы"
        textLabel.shadowOffset = CGSize(width: 3, height: 3)
        textLabel.shadowColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.2)
    }
    
    // MARK: - Add Views
    func addViews() {
        view.addSubview(technicalWorkImage)
        view.addSubview(textLabel)
    }
    
    // MARK: - Setup Constraints
    func setupConstraints() {
        technicalWorkImage.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.center.equalToSuperview()
        }
        
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(technicalWorkImage.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
    }
}


private extension OOPViewController {
    func setupTripleTapReset() {
        let tripleTap = UITapGestureRecognizer(target: self, action: #selector(handleTripleTap))
        tripleTap.numberOfTapsRequired = 3
        self.technicalWorkImage.isUserInteractionEnabled = true
        self.technicalWorkImage.addGestureRecognizer(tripleTap)
    }
    
    private func performRemoteReset() {
        seedUpLoader.resetRemoteToSeeds { [weak self] in
            let done = UIAlertController(
                title: "Готово",
                message: "Удалённая база сброшена к сидовым данным.",
                preferredStyle: .alert
            )
            done.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(done, animated: true)
        }
    }
    
    
}

