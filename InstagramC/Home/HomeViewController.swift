//
//  HomeViewController.swift
//  InstagramC
//
//  Created by Jeferson Dias dos Santos on 07/12/22.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import SDWebImage

class HomeViewController: UIViewController, RecuperarPostagensUsuarioLogadoViewModelDelegate{
    func reloadData() {
        tableViewPostagens.reloadData()
    }
    
    let recuperarPostagensUsuarioLogadoViewModel = RecuperarPostagensUsuarioLogadoViewModel()
    
    @IBOutlet weak var tableViewPostagens: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recuperarPostagensUsuarioLogadoViewModel.delegate = self
        tableViewPostagens.delegate = self
        tableViewPostagens.dataSource = self
        tableViewPostagens.separatorStyle = .none
    }
    
    override func viewDidAppear(_ animated: Bool) {
        recuperarPostagensUsuarioLogadoViewModel.recuperarPostagens()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    //numero de secoes
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //numero de linhas
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recuperarPostagensUsuarioLogadoViewModel.postagens.count
    }
    
    //configurando a celula e fazendo cast para PostagemTableViewCell para ter acesso as propriedades de foto e descricao
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = tableView.dequeueReusableCell(withIdentifier: "celulaPostagens", for: indexPath) as! PostagemTableViewCell
        
        //criando indice / numerando cada postagem da lista
        let indice = indexPath.row
        let postagem = recuperarPostagensUsuarioLogadoViewModel.postagens[indice]
        
        //recuperando dados
        let descricao = postagem["descricao"] as? String
        let urlImagem = postagem["url"] as? String
        
        //alimentando dados
        celula.descricaoPostagem.text = descricao
        
        if urlImagem != nil {
            celula.fotoPostagem.sd_setImage(with: URL(string: urlImagem!))
        }
        return celula
    }
}
