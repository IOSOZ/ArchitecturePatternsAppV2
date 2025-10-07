//
//  MainViewController.swift
//  ArchitecturePatternsApp
//
//  Created by Олег Зуев on 25.08.2025.
//

import UIKit
import SnapKit

final class DesignPatternsViewController: BaseContentViewController {
    
    // MARK: - Properties
    private var tableView = UITableView()
    
    private var storageManager = StorageManager.shared
    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension DesignPatternsViewController: UITableViewDataSource {
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
extension DesignPatternsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.identifier) as? HeaderView else {return UIView()}
        
        let headerTitle = storageManager.getAllPatterns()[section][0].type.rawValue
        
        header.configureUI(with: headerTitle)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
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
private extension DesignPatternsViewController {
    // MARK: - View Setup
    func setupView() {
        setupUI()
        createTable()
        addViews()
        setupConstraints()
    }
    
    // MARK: - UI Setup
    func setupUI() {
        self.view.backgroundColor = UIColor.systemBackground
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

