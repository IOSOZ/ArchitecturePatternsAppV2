//
//  BasePresenter.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 21.10.2025.
//

import Foundation

class BaseContentPresenter: BaseContentPresenterProtocol {
    
    weak var view: BaseContentViewProtocol?
    
    init(view: BaseContentViewProtocol) {
        self.view = view
    }
    
    func didTapRightBarButton() {
        view?.showSideMenu()
    }
}
