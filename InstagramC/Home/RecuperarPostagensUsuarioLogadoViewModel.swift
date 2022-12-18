//
//  RecuperarPostagensUsuarioLogadoViewModel.swift
//  InstagramC
//
//  Created by Jeferson Dias dos Santos on 18/12/22.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

protocol RecuperarPostagensUsuarioLogadoViewModelDelegate: AnyObject {
    func reloadData()
}

class RecuperarPostagensUsuarioLogadoViewModel {
    
    var postagens: [Dictionary<String, Any>] = []
    
    weak var delegate: RecuperarPostagensUsuarioLogadoViewModelDelegate?
    
    let firestore = Firestore.firestore()
    let autenticacao = Auth.auth()
    
    func recuperarPostagens() {
        //limpar lista de postagens para evitar duplicatas e recarregar dados
        postagens.removeAll()
        delegate?.reloadData()
        
        guard let idUsuarioLogado = autenticacao.currentUser?.uid else {return}
        
        //caminho para cada postagem
        firestore.collection("postagens")
            .document(idUsuarioLogado)
            .collection("postagens_usuario")
            .getDocuments { snapshotResultado, erro in
                if let snapshot = snapshotResultado {
                    //varrendo cada document e adcionando a lista de postagens
                    for document in snapshot.documents {
                        let dados = document.data()
                        self.postagens.append(dados)
                    }
                    //apos varrer, recarregar os dados
                    self.delegate?.reloadData()
                }
            }
    }
}
