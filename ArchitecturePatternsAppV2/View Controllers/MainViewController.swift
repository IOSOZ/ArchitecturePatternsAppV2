//
//  MainViewController.swift
//  ArchitecturePatternsApp
//
//  Created by Олег Зуев on 25.08.2025.
//

import UIKit
import SnapKit
#warning("в моем коммите увидишь лишние файлы. хочу чтобы ты изучил гит игнор и в следующий раз их небыло когда я делал коммит")

#warning("достаточно высокий таргет. всегда снижай - возьми привычку -последний минус три - это правило продакшена")

final class MainViewController: UIViewController {
    
    var tableView: UITableView!
    #warning("можно сразу проинициализаировать")
    var objects = [
        Pattern(), Pattern(), Pattern()
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        createTable()
        setupConstraints()
    }

#warning("не используй лучше системные иконки.")

    private func setupUI() {
        self.navigationItem.title = "Паттерны проектирования"
        self.view.backgroundColor = UIColor.systemBackground
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .add)
    }
    
#warning("советую разделять логику построения таблиц и коллекций отдельно, напомни на созвоне")

    private func createTable() {
#warning("это соответственно вынести в класс")
        self.tableView = UITableView()

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PatternTableViewCell.self, forCellReuseIdentifier: PatternTableViewCell.identifier)
        tableView.separatorStyle = .none
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        view.addSubview(tableView)
    }
#warning("правильно! красавчик")

    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}


// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        objects.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "HeaderOne"
        case 1:
            return "HeaderTwo"
        default:
            return "Opps"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PatternTableViewCell.identifier, for: indexPath) as? PatternTableViewCell else { return UITableViewCell() }
        
        let object = objects[indexPath.row]
#warning("лучше создать модель для передачи данных. рассскажу на созвоне")

        cell.nameLabel.text = object.name
        cell.arrowLabel.text = "˃"
        cell.descriptionLabel.text = object.description
        cell.patternImage.image = UIImage(named: object.image)
        cell.viewCounterLabel.text = "Посмотрено раз: \(object.viewCounter)"
        
        cell.favoriteImage.image = {
            object.isFavorite == false ? UIImage(named: "notLike") : UIImage(named: "like")
        }()
        
        
        cell.contentView.layer.cornerRadius = 25
        cell.contentView.clipsToBounds = true
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
#warning("на созвоне расскажешь для чего это")

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
