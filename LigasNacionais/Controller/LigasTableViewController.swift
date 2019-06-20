//
//  LigasTableViewController.swift
//  LigasNacionais
//
//  Created by Lucas Fernandez Nicolau on 18/06/19.
//  Copyright © 2019 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

protocol LigasTableViewControllerDelegate {
    func mostrar(alerta: UIAlertController?, paraSection section: Int?)
    func addLiga(nome: String)
    func addTime(nome: String, naLiga liga: Liga)
}

class LigasTableViewController: UITableViewController {

    var ligas = [Liga]()
    
    // Declaração dos nossos AlertController's
    var addLigaAlertController: AddLigaAlertController?
    var addTimeAlertController: AddTimeAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        // Instanciando nosso ligaAlertController
        addLigaAlertController = AddLigaAlertController(title: "Nova liga", message: "Adicione uma liga nacional", preferredStyle: .alert)
        
        // Configurando o layout - adicionando o TextField e as ações (Action's)
        addLigaAlertController?.configLayout()
        
        addLigaAlertController?.delegate = self
        
        addTimeAlertController = AddTimeAlertController(title: "Novo time", message: "Adicione um time nesta liga", preferredStyle: .alert)
        addTimeAlertController?.configLayout()
        addTimeAlertController?.delegate = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return ligas.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ligas[section].times.count
    }
    
    @IBAction func addLiga(_ sender: UIBarButtonItem) {
        self.mostrar(alerta: addLigaAlertController)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let ligaView = LigaView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: LigaView.ALTURA))
        ligaView.configLayout(paraLiga: ligas[section], naSection: section)
        ligaView.delegate = self
        
        return ligaView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return LigaView.ALTURA
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = UITableViewCell(style: .default, reuseIdentifier: "celula")
        celula.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        celula.textLabel?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        celula.textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        
        let liga = ligas[indexPath.section]
        let time = liga.times[indexPath.row]
        celula.textLabel?.text = time
        
        return celula
    }
}

extension LigasTableViewController: LigasTableViewControllerDelegate {
    
    func mostrar(alerta: UIAlertController?, paraSection section: Int? = nil) {
        guard let alerta = alerta else { return }
        
        if section != nil {
            guard let alertaTime = alerta as? AddTimeAlertController else { return }
            alertaTime.liga = ligas[section!] // Force unwrap pois já verificamos se não é nulo
            self.present(alertaTime, animated: true, completion: nil)
            
        } else {
            self.present(alerta, animated: true, completion: nil)
        }
    }
    
    func addLiga(nome: String) {
        
        // Criação da imagem da bandeira, que se for alguma das previstas pelo app mostra a respectiva
        // bandeira, senão mostra uma padrão
        var imagem: UIImage?
        if let bandeira = Bandeira(rawValue: nome.lowercased().trimmingCharacters(in: .whitespacesAndNewlines).folding(options: .diacriticInsensitive, locale: .current)) {
            imagem = UIImage(named: bandeira.rawValue)
        } else {
            imagem = UIImage(named: Bandeira.padrao.rawValue)
        }
        
        // Cria uma liga e a adiciona no vetor de ligas
        guard let imagemPais = imagem else { return }
        let liga = Liga(nome: nome.uppercased(), imagemPais: imagemPais)
        self.ligas.append(liga)
        
        // Recarrega os dados da tableView
        self.tableView.reloadData()
    }
    
    func addTime(nome: String, naLiga liga: Liga) {
        liga.add(time: nome)
        self.tableView.reloadData()
    }
}
