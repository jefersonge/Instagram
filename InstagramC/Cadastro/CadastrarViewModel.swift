//
//  CadastrarViewModel.swift
//  InstagramC
//
//  Created by Jeferson Dias dos Santos on 15/12/22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class CadastrarViewModel {
    
    func cadastrar(nome: String?, email: String?, senha: String?) {
        let auth = Auth.auth()
        let firestore = Firestore.firestore()
          
        if let nome = nome {
            if let email = email {
                if let senha = senha {
                    
                    auth.createUser(withEmail: email, password: senha) { dadosResultado, erro in
                        if erro == nil {
                            print("Sucesso ao cadastrar usuario")
                            
                            if let idUsuario = dadosResultado?.user.uid {
                                //salvar dados do usurio no firestore criando o caminho abaixo
                                firestore.collection("usuarios")
                                    .document(idUsuario)
                                    .setData([
                                        "nome" : nome,
                                        "email" : email,
                                        "id" : idUsuario
                                    ])
                            }          
                        }else {
                            print("Erro ao cadastrar usuario")
                        }
                    }
                } else {
                    print("Preencha a senha")
                }
            } else {
                print("Preencha o email")
            }
        } else {
            print("Preencha o nome")
        }
    }
}
