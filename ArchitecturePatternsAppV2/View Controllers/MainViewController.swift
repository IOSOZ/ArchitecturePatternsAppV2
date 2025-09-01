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
    var tableView = UITableView()
    var objects = [
        Pattern(), Pattern(), Pattern()
    ]
    var headerTitles = ["ПОРОЖДАЮЩИЕ", "СТРУКТУРНЫЕ", "ПОВЕДЕНЧЕСКИЕ"]
    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        createTable()
        setupTable()
        setupConstraints()
    }
    
#warning("не используй лучше системные иконки.")
    
    // MARK: - UI SetUp
    private func setupUI() {
        self.navigationItem.title = "Паттерны проектирования"
        self.view.backgroundColor = UIColor.systemBackground
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "burgerIcon"))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .add)
    }
    
    // MARK: - Table SetUp
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
    
    // MARK: - Constraints SetUp
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
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
