//
//  PatternDetailsViewController.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 24.09.2025.
//

import PhotosUI
import UIKit
import SnapKit

final class PatternDetailsViewController: UIViewController {
    
    // MARK: - UI Properties
    private var patternImage = UIImageView()
    private var editPhotoButton = UIButton(type: .system)
    private var patternTypeButton = UIButton(type: .system)
    
    private var patternName = UITextField()
    private var editButton: UIBarButtonItem!
    
 
    
    // MARK: - Properties
    private var storeManager = StorageManager.shared
    private var isEditingMode = false
    var object: Pattern!
    
    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Objc methods
    @objc func didTapRightBarButton() {
        isEditingMode.toggle()
        editPhotoButton.isHidden.toggle()
        
        
        if isEditingMode {
            editButton.image = UIImage(systemName: "checkmark.circle")
        } else {
            editButton.image = UIImage(systemName: "pencil")
        }
        
    }
    
    @objc func choosePhoto() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let photo = UIAlertAction(title: "Фото", style: .default) { _ in
            self.openPhotoGallery()
        }
        let file = UIAlertAction(title: "Файлы", style: .destructive) { _ in
            // TODO Работа с файлами
        }
        
        
        let cancel = UIAlertAction(title: "Отмена", style: .cancel)
        
        actionSheet.addAction(photo)
        actionSheet.addAction(file)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true)
    }
}

// MARK: - Private Methods
private extension PatternDetailsViewController {
    
    // MARK: - View Setup
    func setupView() {
        setupUI()
        setUpNavigationBar()
        addViews()
        setupConstraints()
    }
    
    // MARK: - NavBar Setup
    func setUpNavigationBar() {
        editButton = UIBarButtonItem(
            image: UIImage(systemName: "pencil"),
            style: .plain,
            target: self,
            action: #selector(didTapRightBarButton)
        )
        navigationItem.rightBarButtonItem = editButton
    }
    
    
    // MARK: - UI Setup
    func setupUI() {
        editPhotoButton.setTitle("Выбрать изображение", for: .normal)
        editPhotoButton.addTarget(self, action: #selector(choosePhoto), for: .touchUpInside)
        editPhotoButton.isHidden = false
        
        patternImage.layer.borderWidth = 1
        patternImage.layer.borderColor = UIColor.black.cgColor
        patternImage.layer.cornerRadius = 8
        patternImage.clipsToBounds = true
        patternImage.image = object?.image
        
        patternName.font = UIFont(name: "SFPro-Semibold", size: 30)
        patternName.text = object.name
        patternName.isEnabled = false
//        patternName.rightView = UIImageView(image: UIImage(systemName: "pencil"))
//        patternName.rightViewMode = .always
//        Это для отображения режима редактирвоания
        
//        var configButton = UIButton.Configuration.plain()
//        configButton.title = "Тип: \(object.type.rawValue)"
//        configButton.image = UIImage(systemName: "pencil")
//        configButton.imagePadding = 8
//        configButton.imagePlacement = .trailing
//        configButton.titleAlignment = .leading
//        configButton.baseForegroundColor = .black
//        
//        
//        
//        patternTypeButton.configuration = configButton
    
        patternTypeButton.setTitle("Тип: \(object.type.rawValue)", for: .normal)
        patternTypeButton.setImage(UIImage(systemName: "pencil"), for: .normal)
        patternTypeButton.contentHorizontalAlignment = .fill
        patternTypeButton.imageView?.isHidden = false
        patternTypeButton.isEnabled = true
        patternTypeButton.semanticContentAttribute = .forceRightToLeft
        
        
        patternTypeButton.titleLabel?.font = UIFont(name: "SFPro-Semibold", size: 20)
       

        
        self.view.backgroundColor = UIColor.systemBackground
    }
    
    // MARK: - Add Views
    func addViews() {
        view.addSubview(patternImage)
        view.addSubview(editPhotoButton)
        view.addSubview(patternName)
        view.addSubview(patternTypeButton)
    }
    
    // MARK: - Constraints Setup
    func setupConstraints() {
        let screenWidth = UIScreen.main.bounds.width
        
        patternImage.snp.makeConstraints { make in
            make.size.equalTo(screenWidth / 2)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(100)
        }
        
        editPhotoButton.snp.makeConstraints { make in
            make.top.equalTo(patternImage.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        patternName.snp.makeConstraints { make in
            make.top.equalTo(editPhotoButton.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        patternTypeButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(patternName)
            make.top.equalTo(patternName.snp.bottom).offset(24)
        }
    }
    
    func openPhotoGallery() {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.filter = .images
        config.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }
}

// MARK: - Work with Image Methods
extension PatternDetailsViewController: PHPickerViewControllerDelegate {

    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        guard let provider = results.first?.itemProvider else { return }
        
        if provider.canLoadObject(ofClass: UIImage.self) {
            provider.loadObject(ofClass: UIImage.self) { [weak self] image, _ in
                DispatchQueue.main.async {
                    self?.patternImage.image = image as? UIImage
                    self?.object.image = (image as? UIImage)!
                }
            }
        }
            
    }
    
    
}
