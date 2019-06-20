//
//  AddLigaAlertController.swift
//  LigasNacionais
//
//  Created by Lucas Fernandez Nicolau on 19/06/19.
//  Copyright © 2019 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class AddLigaAlertController: UIAlertController {

    var delegate: LigasTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configLayout() {
        
        // Adicionando um textField com um placeholder
        self.addTextField(configurationHandler: { textField in textField.placeholder = "Nome do país" })
        
        // Criando actions de Cancelar e Adicionar
        let cancelarAction = UIAlertAction(title: "Cancelar", style: .cancel)
        let addAction = UIAlertAction(title: "Add", style: .default) { (acao) in
            
            // Checagem da entrada do usuário
            guard let nomeLigaTextField = self.textFields?[0] else { return }
            guard let nomeLiga = nomeLigaTextField.text, nomeLigaTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" else { return }
            
            // Chamada do método addLiga no nosso delegate
            // que, no caso, é a classe LigasTableViewController
            self.delegate?.addLiga(nome: nomeLiga)
        
            nomeLigaTextField.text = ""
        }
        
        // Colocando as actions no AlertController
        self.addAction(cancelarAction)
        self.addAction(addAction)
    }
}
