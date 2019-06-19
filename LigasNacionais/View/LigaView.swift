//
//  LigaView.swift
//  LigasNacionais
//
//  Created by Lucas Fernandez Nicolau on 18/06/19.
//  Copyright © 2019 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class LigaView: UIView {
    
    var imageView: UIImageView?
    var nomeLabel: UILabel?
    var addTimeButton: UIButton?
    
    // Constante estática para utilizarmos quando quisermos o tamanho da section
    static let ALTURA: CGFloat = 60
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        imageView = UIImageView()
        nomeLabel = UILabel()
        addTimeButton = UIButton()
        addTimeButton?.setTitle("Add Time", for: .normal)
        addTimeButton?.setTitleColor(#colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1), for: .normal)
        addTimeButton?.titleLabel?.font = addTimeButton?.titleLabel?.font.withSize(14)
        
        guard let imageView = imageView else { return }
        guard let nomeLabel = nomeLabel else { return }
        guard let addTimeButton = addTimeButton else { return }
        self.addSubview(imageView)
        self.addSubview(nomeLabel)
        self.addSubview(addTimeButton)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nomeLabel.translatesAutoresizingMaskIntoConstraints = false
        addTimeButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Definição das constraints que usaremos em cada subview
        NSLayoutConstraint.activate([
            
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            imageView.heightAnchor.constraint(equalToConstant: 0.5 * self.frame.height),
            imageView.widthAnchor.constraint(equalToConstant: 0.8 * self.frame.height),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            addTimeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            addTimeButton.widthAnchor.constraint(equalToConstant: 70),
            addTimeButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            nomeLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            nomeLabel.trailingAnchor.constraint(equalTo: addTimeButton.leadingAnchor, constant: -8),
            nomeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Função para colocar uma imagem na imageView e um texto no nomeLabel
    // recebendo uma Liga como parâmetro
    func configLayout(paraLiga liga: Liga, naSection section: Int) {
        self.imageView?.image = liga.imagemPais
        self.nomeLabel?.text = liga.nome
        
        // Definindo a tag do botão como sendo igual à section recebida por parâmetro,
        // para sabermos qual section foi selecionada quando um botão for pressionado
        self.addTimeButton?.tag = section
    }
}
