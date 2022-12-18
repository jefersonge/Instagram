//
//  RecuperarUsuarios.swift
//  InstagramC
//
//  Created by Jeferson Dias dos Santos on 18/12/22.
//

import Foundation
import FirebaseFirestore

protocol RecuperarListaUsuariosViewModelDelegate: AnyObject {
    func reloadData()
}

class RecuperarListaUsuariosViewModel {
    
    weak var delegate: RecuperarListaUsuariosViewModelDelegate?
    
    let firestore = Firestore.firestore()
    var usuarios: [Dictionary<String, Any>] = []
    
    func recuperarUsuarios() {
        //limpar lista de usuarios para evitar duplicatas e recarregar dados
        usuarios.removeAll()
        delegate?.reloadData()
        
        //caminho para cada postagem
        firestore.collection("usuarios")
            .getDocuments { snapshotResultado, erro in
                if let snapshot = snapshotResultado {
                    //varrendo cada document e adcionando a lista de usuarios
                    for document in snapshot.documents {
                        let dados = document.data()
                        self.usuarios.append(dados)
                    }
                    //apos varrer, recarregar os dados
                    self.delegate?.reloadData()
                }
            }
    }
}
