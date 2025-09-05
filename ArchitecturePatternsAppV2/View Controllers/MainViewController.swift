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
    private var objects = [
        Pattern(), Pattern(), Pattern()
    ]
    private var headerTitles = ["ПОРОЖДАЮЩИЕ", "СТРУКТУРНЫЕ", "ПОВЕДЕНЧЕСКИЕ"]
    
    var delegate: MainViewControllerDelegate?
    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar()
        setupUI()
        createTable()
        setupTable()
        setupConstraints()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = UIColor.systemBackground
    }
    
    private func setUpNavigationBar() {
        
        let customRightButton = UIButton(type: .system)
        customRightButton.setImage(UIImage(named: "burgerIcon"), for: .normal)
        customRightButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        customRightButton.addTarget(self, action: #selector(didTapRightButton), for: .touchUpInside)
        let rightButton = UIBarButtonItem(customView: customRightButton)
        
        let customLeftButton = UIButton(type: .system)
        customLeftButton.setImage(UIImage(named: "addIconC"), for: .normal)
        customLeftButton.tintColor = .black
        customLeftButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        customLeftButton.addTarget(self, action: #selector(didTapLeftButton), for: .touchUpInside)
        let leftButton = UIBarButtonItem(customView: customLeftButton)
        
        self.navigationItem.leftBarButtonItem = leftButton
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.title = "Паттерны проектирования"
        
    }
    
    // MARK: - Table Setup
    private func createTable() {
        tableView.register(PatternTableViewCell.self, forCellReuseIdentifier: PatternTableViewCell.identifier)
        tableView.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: HeaderView.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupTable() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.sectionHeaderTopPadding = 0
        view.addSubview(tableView)
    }
    
    // MARK: - Constraints Setup
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Private methods
    @objc private func didTapRightButton() {
        var rotationTransform = CGAffineTransform(rotationAngle: .pi / 2)
        if delegate?.toggleSideMenu() == true {
            rotationTransform = CGAffineTransform(rotationAngle: -.pi / 2)
        }
        guard let customView = navigationItem.rightBarButtonItem?.customView else { return }
        UIView.animate(withDuration: 0.3) {
            let currentTransform = customView.transform
            customView.transform = currentTransform.concatenating(rotationTransform)
        }
    }
    
    @objc private func didTapLeftButton() {
        
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        objects.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        headerTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PatternTableViewCell.identifier, for: indexPath) as? PatternTableViewCell else { return UITableViewCell() }
        
        let patternModel = objects[indexPath.row]
        
        cell.setupUI(with: patternModel)
        cell.setUpConstaints(with: indexPath)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.identifier) as? HeaderView else {return UIView()}
        
        header.setupUI(with: headerTitles[section])
        
        return header
    }
}
// MARK: - MainViewControllerDelegate
protocol MainViewControllerDelegate {
    func toggleSideMenu() -> Bool
}

