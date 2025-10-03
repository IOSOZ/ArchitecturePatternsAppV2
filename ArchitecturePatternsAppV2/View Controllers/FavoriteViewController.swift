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
    private var storageManager = StorageManager.shared
    
    weak var container: ContainerViewController?
    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - UITableViewDataSource
extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        storageManager.getFavoritePatterns().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PatternTableViewCell.identifier, for: indexPath) as? PatternTableViewCell else { return UITableViewCell() }
        
        let patternModel = storageManager.getFavoritePatterns()[indexPath.row]
    
        let isFirstCell = indexPath.row == 0 ? true : false
        
        cell.configure(with: patternModel, isFirstCell: isFirstCell)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.identifier) as? HeaderView else {return UIView()}
        
        var headerTitle: String
//        Тут убрать грязь с if
        if storageManager.getFavoritePatterns().count != 0 {
            headerTitle = "ИЗБРАННОЕ"
        } else {
            headerTitle = "ПОКА НЕТ ИЗБРАННОГО =("
        }
        header.configureUI(with: headerTitle)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pattern = storageManager.getPatternWith(indexPath: indexPath)
        storageManager.incrementViewCounterFor(pattern: pattern)
        
        let detailVC = PatternDetailsViewController()
        detailVC.object = storageManager.getPatternWith(indexPath: indexPath)
        
        present(detailVC, animated: true)
        tableView.reloadData()
    }
}

// MARK: - Private Methods
private extension FavoriteViewController {
    
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
    func createTable() {
        tableView.register(PatternTableViewCell.self, forCellReuseIdentifier: PatternTableViewCell.identifier)
        tableView.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: HeaderView.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.sectionHeaderTopPadding = 0
    }
    
    // MARK: - Add Views
    func addViews() {
        view.addSubview(tableView)
    }
    
    // MARK: - Constraints Setup
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
