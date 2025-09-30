//
//  FavoriteViewController.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 30.09.2025.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    
    // MARK: - Properties
    private var tableView = UITableView()
    private var storeManager = StorageManager()
    
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
    
    // MARK: - View Setup
    private func setupView() {
        setupUI()
        createTable()
        addViews()
        setupConstraints()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
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

// MARK: - UITableViewDataSource
extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        storeManager.getFavoritePatterns().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PatternTableViewCell.identifier, for: indexPath) as? PatternTableViewCell else { return UITableViewCell() }
        
        let patternModel = storeManager.getFavoritePatterns()[indexPath.row]
        
        var isFirstCell = false
        
        if indexPath.row == 0 {
            isFirstCell = true
        }
        
        cell.setupUI(with: patternModel, isFirstCell: isFirstCell)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.identifier) as? HeaderView else {return UIView()}
        
        var headerTitle: String
        
        if storeManager.getFavoritePatterns().count != 0 {
            headerTitle = "ИЗБРАННОЕ"
        } else {
            headerTitle = "ПОКА НЕТ ИЗБРАННОГО =("
        }
        header.configureUI(with: headerTitle)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pattern = storeManager.getPatternWith(indexPath: indexPath)
        storeManager.incrementViewCounterFor(pattern: pattern)
        
        let detailVC = PatternDetailsViewController()
        detailVC.object = storeManager.getPatternWith(indexPath: indexPath)
        
        present(detailVC, animated: true)
        tableView.reloadData()
    }
}
