//
//  UpdatePasswordPresenter.swift
//  Documents
//
//  Created by Илья on 09.08.2022.
//

import Foundation



// MARK: - UpdatePasswordPresenterInput

protocol UpdatePasswordPresenterInput: AnyObject {
    func set(view: UpdatePasswordViewControllerInput)
    func buttonCheckPassword(text: String) throws
    func checkingForExistenceOfPassword() -> Bool
    func savingPasswordForComparison(text: String) throws
    func comparisonOfVerificationPassword(text: String) -> Bool
}



// MARK: - UpdatePasswordPresenter

final class UpdatePasswordPresenter: UpdatePasswordPresenterInput {
    
    weak private var view: UpdatePasswordViewControllerInput!
    private let model = CheckStartScreenModel()
    private var passwordForCheckVerification: String?
    
    // Привязка view к презентеру
    func set(view: UpdatePasswordViewControllerInput) {
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
