//
//  MainViewController.swift
//  ArchitecturePatternsApp
//
//  Created by Олег Зуев on 25.08.2025.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    
    // MARK: - Properties
    private var tableView = UITableView()
    
    private var storageManager = StorageManager.shared
    
    weak var container: ContainerViewController?
    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Objc methods
    @objc private func didTapLeftButton() {
        // Ведутся технические работы
    }
    
    @objc private func didTapRightButton() {
        if let isShown = container?.toggleSideMenu() {
            rotateRightButton(isOpen: isShown)
        }
    }
    
    // MARK: - Public Methods
    func rotateRightButton(isOpen: Bool) {
        guard let customView = navigationItem.rightBarButtonItem?.customView else { return }
        
        let targetAngle: CGFloat = isOpen ? -.pi / 2 : 0
        
        UIView.animate(withDuration: 0.3) {
            customView.transform = CGAffineTransform(rotationAngle: targetAngle)
        }
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        storageManager.getAllPatterns()[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        storageManager.getAllPatterns().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PatternTableViewCell.identifier, for: indexPath) as? PatternTableViewCell else { return UITableViewCell() }
        
        let patternModel = storageManager.getPatternWith(indexPath: indexPath)
        
        let isFirstCell = indexPath.row == 0 ? true : false
        
        cell.configure(with: patternModel, isFirstCell: isFirstCell)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.identifier) as? HeaderView else {return UIView()}
        
        let headerTitle = storageManager.getAllPatterns()[section][0].type.rawValue
        
        header.configureUI(with: headerTitle)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pattern = storageManager.getPatternWith(indexPath: indexPath)
        storageManager.incrementViewCounterFor(pattern: pattern)
        
        let detailVC = PatternDetailsViewController()
        detailVC.object = storageManager.getPatternWith(indexPath: indexPath)
        
        navigationController?.pushViewController(detailVC, animated: true)
        tableView.reloadData()
    }
}

// MARK: - Private Methods

private extension MainViewController {
    
    // MARK: - View Setup
    func setupView() {
        setUpNavigationBar()
        setupUI()
        createTable()
        addViews()
        setupConstraints()
    }
    
    // MARK: - UI Setup
    func setupUI() {
        self.view.backgroundColor = UIColor.systemBackground
    }
    
    // MARK: - NavBar Setup
    func setUpNavigationBar() {
        self.navigationItem.leftBarButtonItem = createCustomBarButton(
            with: .addIconC,
            action: #selector(didTapLeftButton),
            tintColor: .black
        )
        self.navigationItem.rightBarButtonItem = createCustomBarButton(
            with: .burgerIcon,
            action:  #selector(didTapRightButton)
        )
        self.navigationItem.title = "Паттерны проектирования"
        
    }
    
    // MARK: - Create Bar Button
    func createCustomBarButton(with image: UIImage, action: Selector, tintColor: UIColor? = nil) -> UIBarButtonItem {
        let customButton = UIButton(type: .system)
        customButton.setImage(image, for: .normal)
        customButton.tintColor = tintColor
        customButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        customButton.addTarget(self, action: action, for: .touchUpInside)
        return UIBarButtonItem(customView: customButton)
        
    }

    // MARK: - Table Setup
    private func createTable() {
        tableView.register(PatternTableViewCell.self, forCellReuseIdentifier: PatternTableViewCell.identifier)
        tableView.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: HeaderView.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.sectionHeaderTopPadding = 0
    }
    
    // MARK: - Add Views
    private func addViews() {
        view.addSubview(tableView)
    }
    
    // MARK: - Constraints Setup
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
