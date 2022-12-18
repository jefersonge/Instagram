//
//  GaleriaCollectionViewController.swift
//  InstagramC
//
//  Created by Jeferson Dias dos Santos on 13/12/22.
//

import UIKit
import FirebaseFirestore
import FirebaseStorageUI


class GaleriaCollectionViewController: UICollectionViewController, RecuperaPostagemUsuarioSelecionadoViewModelDelegate {
    func collectionViewReloadData() {
        collectionView.reloadData()
    }
    
    
    //criada para receber usuario atraves da segueGaleria passada pelo sender no perform e prepare da UsuariosViewController
    var usuario: Dictionary<String, Any>!
    
    let recuperaPostagemUsuarioSelecionadoViewModel = RecuperaPostagemUsuarioSelecionadoViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recuperaPostagemUsuarioSelecionadoViewModel.delegate = self
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        recuperaPostagemUsuarioSelecionadoViewModel.recuperarPostagens(usuario: usuario)
    }
    
    //quantidade de itens
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recuperaPostagemUsuarioSelecionadoViewModel.postagens.count
    }
    //montagem da celula
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celula = collectionView.dequeueReusableCell(withReuseIdentifier: "celulaGaleria", for: indexPath) as! GaleriaCollectionViewCell
        
        
        //criando indice / numerando cada postagem da lista
        let indice = indexPath.row
        let postagem = recuperaPostagemUsuarioSelecionadoViewModel.postagens[indice]
        
        //recuperando dados
        let descricao = postagem["descricao"] as? String
        let urlImagem = postagem["url"] as? String
        
        //alimentando dados
        celula.descricao.text = descricao
        
        if urlImagem != nil {
            celula.foto.sd_setImage(with: URL(string: urlImagem!))
            
        }
        
        return celula
    }
    //ao aparecer tela galeria esconder tabbar
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        
    }
    //ao desaparecer tela galeria esconder tabbar
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
}
