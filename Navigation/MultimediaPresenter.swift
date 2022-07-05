//
//  MultimediaPresenter.swift
//  Navigation
//
//  Created by Илья on 29.06.2022.
//

import Foundation

protocol MultimediaPresenterInput: AnyObject {
    func musicControllerDisplay()
    func videoControllerDisplay()
    func audioRecordControlleDisplay()
}

final class MultimediaPresenter: MultimediaPresenterInput {
    
    weak private var controller: MultimediaPresenterInput!
    
    func setPresenter(controller: MultimediaPresenterInput) {
        self.controller = controller
    }
    
    // Открытие окна с музыкой
    func musicControllerDisplay() {
        let controller = MusicViewController()
        controller.pushViewController(controller, animated: true)
    }
    
}



//// MARK: - FeedPresenterInput
//
//protocol FeedPresenterInput: AnyObject {
//    func buttonPost()
//    func buttonCheckPassword(text: String) throws
//    func set(view: FeedViewControllerInput)
//}
//
//
//
//// MARK: - FeedPresenter
//
//final class FeedPresenter: FeedPresenterInput {
//
//    weak private var view: FeedViewControllerInput!
//    private let model = FeedModel()
//
//    // Привязка view к презентеру
//    func set(view: FeedViewControllerInput) {
//        self.view = view
//    }
//
//    // Обработка нажатие на кнопку "Go post"
//    func buttonPost() {
//        // Должен обрабатывать координатор.
//        print("EVENT --> Нажата кнопка POST")
//    }
//
//    // Проверка пароля
//    func buttonCheckPassword(text: String) throws {
//        guard let view = view else { return }
//        let correctPassword = model.password
//        if text.isEmpty {
//            throw CheckPasswordPostErrors.emptyPassordField
//        } else if text == correctPassword {
//            view.resultCheckPassword(.correct)
//        } else if text != correctPassword {
//            throw CheckPasswordPostErrors.incorrectPassword
//        } else {
//            throw CheckPasswordPostErrors.unowned
//        }
//    }
//}
