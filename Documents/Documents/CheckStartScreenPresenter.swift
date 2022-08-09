//
//  CheckStartScreenPresenter.swift
//  Documents
//
//  Created by Илья on 09.08.2022.
//

import Foundation



// MARK: - FeedPresenterInput

protocol CheckStartScreenPresenterInput: AnyObject {
    func set(view: CheckStartScreenViewControllerInput)
    func buttonCheckPassword(text: String) throws
    func checkingForExistenceOfPassword() -> Bool
    func savingPasswordForComparison(text: String) throws
    func comparisonOfVerificationPassword(text: String) -> Bool
}



// MARK: - FeedPresenter

final class CheckStartScreenPresenter: CheckStartScreenPresenterInput {
    
    weak private var view: CheckStartScreenViewControllerInput!
    private let model = CheckStartScreenModel()
    private var passwordForCheckVerification: String?
    
    // Привязка view к презентеру
    func set(view: CheckStartScreenViewControllerInput) {
        self.view = view
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
