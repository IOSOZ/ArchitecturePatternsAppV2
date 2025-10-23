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
    
    var presenter: DesignPatternsPresenter!
    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    @objc override func didTapLeftButton() {
    
        let patternCreationVC = PatternCreationBuilder.createModule(for: PatternCreationViewController(), storage: StorageManager())
        navigationController?.pushViewController(patternCreationVC, animated: true)
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
        presenter.patterns[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter.patterns.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PatternTableViewCell.identifier, for: indexPath) as? PatternTableViewCell else { return UITableViewCell() }
    
        cell.delegate = self
        
        let patternModel = presenter.patterns[indexPath.section][indexPath.row]
        
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
        presenter.didSelectRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            self.presenter.didSwipeToDelete(at: indexPath)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension DesignPatternsViewController: DesignPatternsViewProtocol {
    func showPatternCreation() {
#warning("Тут сделать чрез билдер")
//        let patternCreationVC = PatternCreationViewController()
//        navigationController?.pushViewController(patternCreationVC, animated: true)
    }
    
    func reloadData() {
        tableView.reloadData()
    }

    func showPatternDetails(forID id: UUID) {
        let detailVC = PatternDetailsBuilder.createModule(for: PatternDetailsViewController(), storage: StorageManager(), objectID: id)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension DesignPatternsViewController: PatternTableViewCellDelegate {
    func didTapFavorite(on cell: PatternTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        presenter.didTapFavorite(at: indexPath)
    }
}
