//
//  RecuperaPostagens.swift
//  InstagramC
//
//  Created by Jeferson Dias dos Santos on 16/12/22.
//

import Foundation
import FirebaseFirestore


struct RecuperaPostagens {
    
var postagens: [Dictionary<String, Any>] = []
    
    mutating func recuperarPostagens() {

        //limpar lista de postagens para evitar duplicatas e recarregar dados
        postagens.removeAll()
        tableViewPostagens.reloadData()
        
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
                    self.tableViewPostagens.reloadData()
                }
            }
    }
}
