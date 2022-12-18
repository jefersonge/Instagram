//
//  RecuperaPostagem.swift
//  InstagramC
//
//  Created by Jeferson Dias dos Santos on 17/12/22.
//

import Foundation
import FirebaseFirestore

protocol RecuperaPostagemUsuarioSelecionadoViewModelDelegate: AnyObject {
    func collectionViewReloadData()
}

class RecuperaPostagemUsuarioSelecionadoViewModel {
    var postagens: [Dictionary<String, Any>] = []
    
    
    weak var delegate: RecuperaPostagemUsuarioSelecionadoViewModelDelegate?
    
    let firestore = Firestore.firestore()
    
    func recuperarPostagens(usuario: Dictionary<String, Any> ) {
        //limpar lista de postagens para evitar duplicatas e recarregar dados
        postagens.removeAll()
        delegate?.collectionViewReloadData()
        guard let idUsuarioSelecionado = usuario["id"] as? String else {return}
        
        
        //caminho para cada postagem
        firestore.collection("postagens")
            .document(idUsuarioSelecionado)
            .collection("postagens_usuario")
            .getDocuments { snapshotResultado, erro in
                if let snapshot = snapshotResultado {
                    //varrendo cada document e adcionando a lista de postagens
                    for document in snapshot.documents {
                        let dados = document.data()
                        self.postagens.append(dados)
                    }
                    //apos varrer, recarregar os dados
                    self.delegate?.collectionViewReloadData()
                }
            }
    }
}
