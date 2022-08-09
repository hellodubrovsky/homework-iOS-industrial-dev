//
//  FeedPresenter.swift
//  Navigation
//
//  Created by Илья on 08.06.2022.
//

import Foundation



// MARK: - FeedPresenterInput

protocol FeedPresenterInput: AnyObject {
    func set(view: FeedViewControllerInput)
    func buttonPost()
    func buttonCheckPassword(text: String) throws
    func checkingForExistenceOfPassword() -> Bool
    func savingPasswordForComparison(text: String) throws
    func comparisonOfVerificationPassword(text: String) -> Bool
}



// MARK: - FeedPresenter

final class FeedPresenter: FeedPresenterInput {
    
    weak private var view: FeedViewControllerInput!
    private let model = FeedModel()
    private var passwordForCheckVerification: String?
    
    // Привязка view к презентеру
    func set(view: FeedViewControllerInput) {
        self.view = view
    }
    
    // Обработка нажатие на кнопку "Go post"
    func buttonPost() {
        // Должен обрабатывать координатор.
        print("EVENT --> Нажата кнопка POST")
    }
    
    // Проверка пароля
    func buttonCheckPassword(text: String) throws {
        guard let view = view else { return }
        guard text.rangeOfCharacter(from: CharacterSet.whitespaces) == nil else { throw CheckPasswordPostErrors.incorrectSymbols }
        let correctPassword = model.password
        if text == correctPassword {
            view.resultCheckPassword(.correct)
        } else if text != correctPassword {
            throw CheckPasswordPostErrors.invalidPassword
        } else {
            throw CheckPasswordPostErrors.unowned
        }
    }
    
    /// Сохранение в presenter пароля, который в дальнейшем нужно сравнить.
    func savingPasswordForComparison(text: String) throws {
        guard text.rangeOfCharacter(from: CharacterSet.whitespaces) == nil else { throw CheckPasswordPostErrors.incorrectSymbols }
        self.passwordForCheckVerification = text
    }
    
    /// Сравнение переданного пароля (который планируется сохранить), с уже сохраненным в презентере.
    func comparisonOfVerificationPassword(text: String) -> Bool {
        guard text == self.passwordForCheckVerification else { return false }
        
        // Сохранение нового пароля.
        KeychainManager.shared.addNewUserWith(password: text)
        return true
    }
    
    /// Проверка, имеется ли у пользователя сохраненный пароль.
    func checkingForExistenceOfPassword() -> Bool {
        return model.password != nil
    }
}
