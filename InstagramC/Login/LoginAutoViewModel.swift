//
//  LoginAutoViewModel.swift
//  InstagramC
//
//  Created by Jeferson Dias dos Santos on 15/12/22.
//

import Foundation
import FirebaseAuth

protocol LoginAutoViewModelDelegate: AnyObject {
    func chamarSegue()
}

class LoginAutoViewModel {
    
    weak var delegate: LoginAutoViewModelDelegate?
    
    func loginAutomatico() {
        let auth = Auth.auth()
        //LOGIN AUTOMATICO
        auth.addStateDidChangeListener { autenticacao, usuario in
            if usuario != nil {
                print("usario logado")
                self.delegate?.chamarSegue()
            } else {
                print("usuario nao esta logado")
            }
        }
    }   
}
