//
//  HeaderView.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 31.08.2025.
//

import UIKit

final class HeaderView: UITableViewHeaderFooterView {
    // MARK: - Public Properties
    static var identifier: String {
        String(describing: Self.self)
    }
    
    // MARK: - UI Properties
    private var containerView = UIView()
    private var headerLabel = UILabel()
    
    // MARK: - Initialization
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func configureUI(with headerTitle: String) {
        headerLabel.attributedText = NSAttributedString(
            string: headerTitle,
            attributes: attributedTextProperties
        )
    }
}

// MARK: - Private Extension
private extension HeaderView {

    // MARK: - View SetUp
    func setupView() {
        addViews()
        setupUI()
        setupConstraints()
        
    }

    // MARK: - Add Views
    func addViews() {
        containerView.addSubview(headerLabel)
        contentView.addSubview(containerView)
    }

    // MARK: - Constraints SetUp
    func setupConstraints() {

        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        }
        
        headerLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }
    }
    
    // MARK: - UI SetUp
    func setupUI() {
        headerLabel.numberOfLines = 0
    }
    
    // MARK: - Attributed Text Properties
    var attributedTextProperties: [NSAttributedString.Key: Any] {
        let headerLabelStyle = NSMutableParagraphStyle()
        headerLabelStyle.minimumLineHeight = 13
        headerLabelStyle.alignment = .left
        return [
            .font: UIFont(name: "SFPro-Regular", size: 13) ?? .systemFont(ofSize: 13, weight: .semibold),
            .foregroundColor: UIColor(named: "labelSecondary") ?? .gray,
            .paragraphStyle: headerLabelStyle,
        ]
    }

}
