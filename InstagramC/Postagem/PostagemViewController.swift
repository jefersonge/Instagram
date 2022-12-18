//
//  PostagemViewController.swift
//  InstagramC
//
//  Created by Jeferson Dias dos Santos on 08/12/22.
//

import UIKit
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore

//Aderir a UIImagePickerControllerDelegate, UINavigationControllerDelegate para uso do imagePicker
class PostagemViewController: UIViewController, SalvarPostagemViewModelDelegate {
    func navigationPopView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var descricao: UITextField!
    //criamos o imagePicker que é UIImagePickerController instaciada
    var imagePicker = UIImagePickerController()
    
    let salvarPostagemViewModel = SalvarPostagemViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //o delegate do imagepicker
        imagePicker.delegate = self
        
        salvarPostagemViewModel.delegate = self
    }
    
    @IBAction func selecionarImagem(_ sender: Any) {
        //criando o imagepicker, seletor de imagem
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true)
    }
    
    
    
    @IBAction func salvarPostagem(_ sender: Any) {
        
        salvarPostagemViewModel.salvarPostagem(imagem: imagem.image, descricao: descricao.text)
    }
}

extension PostagemViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //metodo que recupera a imagem selecionada
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imagemRecuperada = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        //apos recuperar a imagem selecionada jogamos ela no nosso image view imagem
        self.imagem.image = imagemRecuperada
        //fechar a tela apos selecionar a imagem
        imagePicker.dismiss(animated: true)
    }
}
