//
//  PatternDetailsViewController.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 24.09.2025.
//

import PhotosUI
import UIKit
import SnapKit

protocol PatternDetailsViewControllerDelegate: AnyObject {
    func updatePatternType(_ patternType: PatternType)
}

final class PatternDetailsViewController: UIViewController {
    
    
    // MARK: - UI Properties
    private var patternImage = UIImageView()
    private var editPhotoButton = UIButton(type: .system)
    private var patternTypeLabel = UILabel()
    private let chooseTypeButton = UIButton()
    
    private var patternName = UITextField()
    private var editButton: UIBarButtonItem!
    private let patternDescription = UITextView()
    
    // MARK: - Properties
    private var storeManager = StorageManager.shared
    private var isEditingMode = false
    var object: Pattern!
    private var modifyObject: Pattern!
    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modifyObject = object
        setupView()
    }
    
    // MARK: - Objc methods
    @objc func didTapRightBarButton() {
        toggleEditMode()
        
        if isEditingMode {
            navigationItem.leftBarButtonItem = UIBarButtonItem(
                barButtonSystemItem: .cancel,
                target: self,
                action: #selector(cancelEditing)
                
            )} else {
                modifyObject.image = patternImage.image ?? UIImage(resource: .technicalWork)
                modifyObject.name = patternName.text ?? ""
                modifyObject.description = patternDescription.text
                storeManager.updatePattern(modifyObject)
                
                object = modifyObject
                
                navigationItem.leftBarButtonItem = nil
            }
    }
    
    @objc func choosePatternTypeButtonTapped() {
        let bottomVC = BottomSheetViewController(selectedType: object.type)
        bottomVC.delegate = self
        present(bottomVC, animated: true,)
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
    
    @objc func cancelEditing() {
        navigationItem.leftBarButtonItem = nil
        editButton.image = UIImage(systemName: "pencil")
        updateData(with: object)
        toggleEditMode()
    }
}

// MARK: - Private Methods
private extension PatternDetailsViewController {
    
    // MARK: - Setup View
    func setupView() {
        setupUI()
        updateData(with: object)
        setUpNavigationBar()
        addViews()
        setupConstraints()
    }
    
    // MARK: - Setup NavBar
    func setUpNavigationBar() {
        editButton = UIBarButtonItem(
            image: UIImage(resource: .editMode),
            style: .plain,
            target: self,
            action: #selector(didTapRightBarButton)
        )
        navigationItem.rightBarButtonItem = editButton
    }
    
    // MARK: - Setup UI
    func setupUI() {
        editPhotoButton.setTitle("Выбрать изображение", for: .normal)
        editPhotoButton.addTarget(self, action: #selector(choosePhoto), for: .touchUpInside)
        editPhotoButton.isHidden = true
        
        patternImage.layer.borderWidth = 1
        patternImage.layer.borderColor = UIColor.black.cgColor
        patternImage.layer.cornerRadius = 8
        patternImage.clipsToBounds = true
        
        patternName.font = UIFont(name: "SFPro-Semibold", size: 32)
        patternName.text = object.name
        patternName.isEnabled = false
        patternName.rightView = UIImageView(image: UIImage(resource: .pencil))
        patternName.rightViewMode = .always
        patternName.rightView?.isHidden = true
        patternName.layer.borderWidth = 0
        patternName.layer.borderColor = UIColor.systemGray4.cgColor
        patternName.layer.cornerRadius = 8
        
        patternTypeLabel.textColor = .black
        patternTypeLabel.font = UIFont(name: "SFPro-Semibold", size: 20)
        
        chooseTypeButton.setImage(UIImage(resource: .chevronUP), for: .normal)
        chooseTypeButton.tintColor = .black
        chooseTypeButton.addTarget(self, action: #selector(choosePatternTypeButtonTapped), for: .touchUpInside)
        chooseTypeButton.isHidden = true
        
        patternDescription.font = UIFont(name: "SFPro-Regular", size: 16)
        patternDescription.isEditable = false
        patternDescription.isScrollEnabled = true
        patternDescription.layer.borderWidth = 0
        patternDescription.layer.borderColor = UIColor.systemGray4.cgColor
        patternDescription.layer.cornerRadius = 8
        
        self.view.backgroundColor = UIColor.systemBackground
    }
    
    // MARK: - Update Data
    func updateData(with _ : Pattern) {
        patternImage.image = object.image
        patternName.text = object.name
        patternTypeLabel.text = "Тип: \(object.type.title)"
        patternDescription.text = object.description
    }
    
    // MARK: - Add Views
    func addViews() {
        view.addSubview(patternImage)
        view.addSubview(editPhotoButton)
        view.addSubview(patternName)
        view.addSubview(patternTypeLabel)
        view.addSubview(chooseTypeButton)
        view.addSubview(patternDescription)
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
            make.top.equalTo(patternImage.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
        }
        
        patternName.snp.makeConstraints { make in
            make.top.equalTo(editPhotoButton.snp.bottom).offset(0)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        patternTypeLabel.snp.makeConstraints { make in
            make.leading.equalTo(patternName)
            make.top.equalTo(patternName.snp.bottom).offset(24)
        }
        
        chooseTypeButton.snp.makeConstraints { make in
            make.bottom.top.equalTo(patternTypeLabel)
            make.trailing.equalTo(patternName)
            make.size.equalTo(24)
            
        }
        
        patternDescription.snp.makeConstraints { make in
            make.top.equalTo(patternTypeLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
        }
    }
    
    // MARK: - Open Photo Gallery
    func openPhotoGallery() {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.filter = .images
        config.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    // MARK: - Toggle Edit Mode
    func toggleEditMode() {
        isEditingMode.toggle()
        self.editPhotoButton.isHidden = !self.isEditingMode
        self.patternName.isEnabled = self.isEditingMode
        self.patternName.rightView?.isHidden = !self.isEditingMode
        self.patternDescription.isEditable = self.isEditingMode
        self.patternName.rightView?.isHidden = !self.isEditingMode
        self.chooseTypeButton.isHidden = !self.isEditingMode
        self.patternDescription.layer.borderWidth = self.isEditingMode ? 1 : 0
        self.patternName.layer.borderWidth = self.isEditingMode ? 1 : 0
        self.editButton.image = UIImage(resource: self.isEditingMode ? .done : .editMode)
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

// MARK: - PatternDetailsViewControllerDelegate
extension PatternDetailsViewController: PatternDetailsViewControllerDelegate {
    func updatePatternType(_ patternType: PatternType) {
        patternTypeLabel.text = "Тип: \(patternType.title)"
        modifyObject.type = patternType
        
    }
}
