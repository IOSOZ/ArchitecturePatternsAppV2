//
//  MainViewController.swift
//  ArchitecturePatternsApp
//
//  Created by Олег Зуев on 25.08.2025.
//

import UIKit
import SnapKit

protocol DesignPatternsInput: AnyObject {
    func render(sections: [[Pattern]])
}

final class DesignPatternsViewController: BaseContentViewController {
    // MARK: - VIPER
    var presenter: DesignPatternsViewOutput!
    
    // MARK: - Properties
    private var tableView = UITableView()
    private var data: [[Pattern]] = []
    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillShow()
    }
    
    @objc override func didTapLeftButton() {
        let patternCreationVC = GlobalBuilder.create(.patternCreation)
        navigationController?.pushViewController(patternCreationVC, animated: true)
    }
    
    @objc override func didTapRightButton() {
        presenter.userDidTapSideMenu()
    }
    
}

// MARK: - Private Methods
private extension DesignPatternsViewController {
    // MARK: - View Setup
    func setupView() {
        setupUI()
        setupTableView()
        addViews()
        setupConstraints()
    }
    
    // MARK: - UI Setup
    func setupUI() {
        self.view.backgroundColor = UIColor.systemBackground
    }

    // MARK: - Table Setup
    private func setupTableView() {
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
extension DesignPatternsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PatternTableViewCell.identifier, for: indexPath) as? PatternTableViewCell else { return UITableViewCell() }
    
        cell.delegate = self
        
        let patternModel = data[indexPath.section][indexPath.row]
        
        let isFirstCell = indexPath.row == 0 ? true : false
        
        cell.configure(with: patternModel, isFirstCell: isFirstCell)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension DesignPatternsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.identifier) as? HeaderView else {return UITableViewHeaderFooterView()}
        let headerTitle = PatternType.allCases[section].title
        header.configureUI(with: headerTitle)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.userDidSelectRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            self.presenter.userDidSwipeToDelete(at: indexPath)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension DesignPatternsViewController: DesignPatternsInput {
    func render(sections: [[Pattern]]) {
        data = sections
        tableView.reloadData()
    }
}

extension DesignPatternsViewController: PatternTableViewCellDelegate {
    func didTapFavorite(on cell: PatternTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        presenter.userDidTapFavorite(at: indexPath)
    }
}

