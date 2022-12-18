//
//  UsuariosViewController.swift
//  InstagramC
//
//  Created by Jeferson Dias dos Santos on 07/12/22.
//

import UIKit

class UsuariosViewController: UIViewController, RecuperarListaUsuariosViewModelDelegate {
    func reloadData() {
        tableViewUsuarios.reloadData()
    }
    
    @IBOutlet weak var searchBarUsuarios: UISearchBar!
    @IBOutlet weak var tableViewUsuarios: UITableView!
    
    var recuperarListaUsuariosViewModel = RecuperarListaUsuariosViewModel()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        recuperarListaUsuariosViewModel.delegate = self
        tableViewUsuarios.delegate = self
        tableViewUsuarios.dataSource = self
        searchBarUsuarios.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        recuperarListaUsuariosViewModel.recuperarUsuarios()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueGaleria" {
            let vcDestino = segue.destination as! GaleriaCollectionViewController
            vcDestino.usuario = sender as? Dictionary
        }
    }
}

extension UsuariosViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recuperarListaUsuariosViewModel.usuarios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = tableView.dequeueReusableCell(withIdentifier: "celulaUsuario", for: indexPath)
        let indice = indexPath.row
        let usuario = recuperarListaUsuariosViewModel.usuarios[indice]
        let nome = usuario["nome"] as? String
        let email = usuario["email"] as? String
        celula.textLabel?.text = nome
        celula.detailTextLabel?.text = email
        return celula
    }
    
    //RECUPERANDO LINHA CLICADA, PARA RECUPERAR O USUARIO E ENVIAR PARA A PROXIMA TELA
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewUsuarios.deselectRow(at: indexPath, animated: true)
        let indice = indexPath.row
        let usuario = recuperarListaUsuariosViewModel.usuarios[indice]
        performSegue(withIdentifier: "segueGaleria", sender: usuario)
    }
}

extension UsuariosViewController: UISearchBarDelegate {
    //AO PRESSIONAR O BOTAO PESQUISA
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let textoPesquisa = searchBar.text {
            if textoPesquisa != ""{
                pesquisarUsuarios(texto: textoPesquisa)
            }
        }
    }
    
    //se limpar a pesquisa recuperaUsuarios da lista - do firestore no caso
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
            recuperarListaUsuariosViewModel.recuperarUsuarios()
        }
    }
    
    //METODO QUE PESQUISA USUARIOS
    func pesquisarUsuarios(texto: String) {
        let listaFiltro: [Dictionary<String, Any>] = recuperarListaUsuariosViewModel.usuarios
        recuperarListaUsuariosViewModel.usuarios.removeAll()
        for item in listaFiltro {
            if let nome = item["nome"] as? String {
                if nome.lowercased().contains(texto.lowercased()) {
                    self.recuperarListaUsuariosViewModel.usuarios.append(item)
                }
            }
        }
        tableViewUsuarios.reloadData()
    }
}
