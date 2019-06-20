//
//  AddTimeAlertController.swift
//  LigasNacionais
//
//  Created by Lucas Fernandez Nicolau on 19/06/19.
//  Copyright © 2019 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class AddTimeAlertController: UIAlertController {

    var delegate: LigasTableViewControllerDelegate?
    var liga: Liga?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configLayout() {
        
        self.addTextField(configurationHandler: { textField in textField.placeholder = "Nome do time" })
        
        let cancelarAction = UIAlertAction(title: "Cancelar", style: .cancel)
        let addAction = UIAlertAction(title: "Add", style: .default) { (action) in
            
            guard let nomeTimeTextField = self.textFields?[0] else { return }
            guard let nomeTime = nomeTimeTextField.text, nomeTimeTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" else { return }
            
            guard let liga = self.liga else { return }
            self.delegate?.addTime(nome: nomeTime.uppercased(), naLiga: liga)
            
            nomeTimeTextField.text = ""
        }
        
        self.addAction(cancelarAction)
        self.addAction(addAction)
    }

}
