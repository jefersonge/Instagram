//
//  CadastroViewController.swift
//  InstagramC
//
//  Created by Jeferson Dias dos Santos on 06/12/22.
//

import UIKit

class CadastroViewController: UIViewController {
    
    @IBOutlet weak var campoNome: UITextField!
    
    @IBOutlet weak var campoEmail: UITextField!
    
    @IBOutlet weak var campoSenha: UITextField!
    
    let cadastrar: CadastrarViewModel = CadastrarViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cadastrar(_ sender: Any) {
        cadastrar.cadastrar(nome: campoNome.text, email: campoEmail.text, senha: campoSenha.text)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}

