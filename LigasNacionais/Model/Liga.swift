//
//  Liga.swift
//  LigasNacionais
//
//  Created by Lucas Fernandez Nicolau on 18/06/19.
//  Copyright © 2019 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

enum Bandeira: String {
    case brasil = "brasil"
    case inglaterra = "inglaterra"
    case italia = "italia"
    case espanha = "espanha"
    case portugal = "portugal"
    case padrao = "padrao"
}

class Liga {
    var nome: String
    var imagemPais: UIImage
    var times = [String]()
    
    init(nome: String, imagemPais: UIImage) {
        self.nome = nome
        self.imagemPais = imagemPais
    }
    
    func add(time: String) {
        self.times.append(time)
    }
    
    func remover(timeNaPosicao posicao: Int) {
        self.times.remove(at: posicao)
    }
}
