//
//  HeaderView.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 31.08.2025.
//

import UIKit

final class HeaderView: UITableViewHeaderFooterView {
    // MARK: - Public Properties
    static var identifier : String {
        String(describing: Self.self)
    }
    
    // MARK: - Private Properties
    private var containerView = UIView()
    private var headerLabel = UILabel()
    
    // MARK: - Initialization
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Constraints SetUp
    func setupConstraints() {
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.bottom.equalToSuperview().inset(16)
        }
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.bottom.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
        // MARK: - UI SetUP
    func setupUI(with headerTitle: String) {
        headerLabel.numberOfLines = 0
        let headerLabelStyle = NSMutableParagraphStyle()
        headerLabelStyle.minimumLineHeight = 13
        headerLabelStyle.alignment = .left
        let headerLabelAttributes: [NSAttributedString.Key : Any] = [
            .font : UIFont(name: "SFPro-Regular", size: 13) ?? .systemFont(ofSize: 13, weight: .semibold),
            .foregroundColor : UIColor(named: "labelSecondary") ?? .gray,
            .paragraphStyle: headerLabelStyle
        ]
        headerLabel.attributedText = NSAttributedString(string: headerTitle, attributes: headerLabelAttributes)
    }
}
