//
//  LigasTableViewController.swift
//  LigasNacionais
//
//  Created by Lucas Fernandez Nicolau on 18/06/19.
//  Copyright © 2019 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class LigasTableViewController: UITableViewController {

    var ligas = [Liga]()
    
    // Declaração dos nossos AlertController's
    var ligaAlertController: UIAlertController?
    var timeAlertController: UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        // Chamada da nossas função de configuração do AlertController
        configLigaAlertController()
    }
    
    func configLigaAlertController() {
        // Instanciando o AlertController com um título e um texto a ser exibido
        ligaAlertController = UIAlertController(title: "Liga Nacional", message: "Adicione uma liga nacional", preferredStyle: .alert)
        
        // Adicionando um textField com um placeholder no nosso AlertController
        ligaAlertController?.addTextField(configurationHandler: { textField in textField.placeholder = "Nome do país" })
        
        // Criando actions de Cancelar e Add
        let cancelarAction = UIAlertAction(title: "Cancelar", style: .cancel)
        let addAction = UIAlertAction(title: "Add", style: .default) { (action) in
            
            // Pegando o valor preenchido pelo usuário e checando se não é um espaço em branco
            guard let nomeLigaTextField = self.ligaAlertController?.textFields?[0] else { return }
            guard let nomeLiga = nomeLigaTextField.text, nomeLigaTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" else { return }
            
            // Criação da imagem da bandeira, que se for alguma das previstas pelo app mostra a respectiva
            // bandeira, senão mostra uma padrão
            var imagem: UIImage?
            if let bandeira = Bandeira(rawValue: nomeLiga.lowercased().trimmingCharacters(in: .whitespacesAndNewlines).folding(options: .diacriticInsensitive, locale: .current)) {
                imagem = UIImage(named: bandeira.rawValue)
            } else {
                imagem = UIImage(named: Bandeira.padrao.rawValue)
            }
            
            // Cria uma liga e a adiciona no vetor de ligas
            guard let imagemPais = imagem else { return }
            let liga = Liga(nome: nomeLiga.uppercased(), imagemPais: imagemPais)
            self.ligas.append(liga)
            
            // Recarrega os dados da tableView
            self.tableView.reloadData()
            
            // Limpa o textField para estar vazio na próxima vez que aparecer
            nomeLigaTextField.text = ""
        }
        
        // Colocando as actions no AlertController
        ligaAlertController?.addAction(cancelarAction)
        ligaAlertController?.addAction(addAction)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return ligas.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ligas[section].times.count
    }
    
    @IBAction func addLiga(_ sender: UIBarButtonItem) {
        guard let ligaAlertController = ligaAlertController else { return }
        self.present(ligaAlertController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let ligaView = LigaView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: LigaView.ALTURA))
        ligaView.configLayout(paraLiga: ligas[section], naSection: section)
        
        // Definindo uma ação para ser executada quando o botão for clicado
        ligaView.addTimeButton?.addTarget(self, action: #selector(mostrarTimeAlertController(botao:)), for: .touchUpInside)
        
        return ligaView
    }
    
    @objc func mostrarTimeAlertController(botao: UIButton) {
        configTimeAlertController(paraSection: botao.tag)
        
        guard let timeAlertController = timeAlertController else { return }
        self.present(timeAlertController, animated: true, completion: nil)
    }
    
    func configTimeAlertController(paraSection section: Int) {
        timeAlertController = UIAlertController(title: "Novo Time", message: "Adicione um time neste liga", preferredStyle: .alert)
        timeAlertController?.addTextField(configurationHandler: { textField in textField.placeholder = "Nome do time" })
        
        let cancelarAction = UIAlertAction(title: "Cancelar", style: .cancel)
        let addAction = UIAlertAction(title: "Add", style: .default) { (action) in
            
            guard let nomeTimeTextField = self.timeAlertController?.textFields?[0] else { return }
            guard let nomeTime = nomeTimeTextField.text, nomeTimeTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" else { return }
            
            self.ligas[section].add(time: nomeTime.uppercased())
            
            let indexPath = IndexPath(row: self.ligas[section].times.count - 1, section: section)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
            
            nomeTimeTextField.text = ""
        }
        
        timeAlertController?.addAction(cancelarAction)
        timeAlertController?.addAction(addAction)
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
