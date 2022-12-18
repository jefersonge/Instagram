//
//  LogarViewModel.swift
//  InstagramC
//
//  Created by Jeferson Dias dos Santos on 15/12/22.
//

import Foundation
import FirebaseAuth

struct LogarViewModel {
    
    func logar(email: String?, senha: String?){
        let auth = Auth.auth()
        if let email = email {
            if let senha = senha {
                auth.signIn(withEmail: email, password: senha) {  usuario, erro in
                    if erro == nil {
                        print("Sucesso ao logar usuario")
                    }else {
                        print("Erro ao logar usuario")
                    }
                }
            }else {
                print("Preencha sua senha")
            }
        }else {
            print("Preencha seu email")
        }
    }
}
