//
//  LogoutViewModel.swift
//  InstagramC
//
//  Created by Jeferson Dias dos Santos on 15/12/22.
//

import Foundation
import FirebaseAuth

struct LogoutViewModel {
    
    func logout () {
        let auth = Auth.auth()
        do {
            try auth.signOut()
            print("Sucesso ao deslogar usuario")
        } catch  {
            print("Erro ao deslogar usuario")
        }
    }
    
}
