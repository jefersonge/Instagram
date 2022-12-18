//
//  LoginViewController.swift
//  InstagramC
//
//  Created by Jeferson Dias dos Santos on 06/12/22.
//

import UIKit

class LoginViewController: UIViewController, LoginAutoViewModelDelegate{
    func chamarSegue() {
        performSegue(withIdentifier: "segueLoginAutomatico", sender: nil)
    }
    
    @IBOutlet weak var campoEmail: UITextField!
    @IBOutlet weak var campoSenha: UITextField!
    
    let logar: LogarViewModel = LogarViewModel()
    let logout: LogoutViewModel = LogoutViewModel()
    let loginAuto: LoginAutoViewModel = LoginAutoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginAuto.delegate = self
        loginAuto.loginAutomatico()
    }
    
    //LOGOUT AO CLICAR EM SAIR
    @IBAction func unwindToLogin(_ unwindSegue: UIStoryboardSegue) {
        logout.logout()
    }
    
    @IBAction func logar(_ sender: Any) {
        logar.logar(email: campoEmail.text, senha: campoSenha.text)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }    
}
