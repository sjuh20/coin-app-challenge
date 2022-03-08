//
//  DetalhesViewBlack.swift
//  CoinAppChallenge
//
//  Created by Natanael Alves Pereira on 08/03/22.
//

import UIKit

class DetalhesViewBlack: UIView {

    lazy var volumeLabel:UILabel = {
        let valor = UILabel()
        valor.translatesAutoresizingMaskIntoConstraints = false
        valor.textColor = .white
        valor.font = UIFont.boldSystemFont(ofSize: 21)
        valor.text = "volumes negociados"

        return valor
    }()
    
    lazy var ultimaHrLabel:UILabel = {
        let valor = UILabel()
        valor.translatesAutoresizingMaskIntoConstraints = false
        valor.textColor = .white
        valor.font = UIFont.boldSystemFont(ofSize: 17)
        valor.text = "Última Hora"

        return valor
    }()

    lazy var ultimoMesLabel:UILabel = {
        let valor = UILabel()
        valor.translatesAutoresizingMaskIntoConstraints = false
        valor.textColor = .white
        valor.font = UIFont.boldSystemFont(ofSize: 17)
        valor.text = "Último Mês"

        return valor
    }()
    
    lazy var ultimoAnoLabel:UILabel = {
        let valor = UILabel()
        valor.translatesAutoresizingMaskIntoConstraints = false
        valor.textColor = .white
        valor.font = UIFont.boldSystemFont(ofSize: 17)
        valor.text = "Último Ano"
        
        return valor
    }()

    lazy var valorHr:UILabel = {
        let valor = UILabel()
        valor.translatesAutoresizingMaskIntoConstraints = false
        valor.textColor = .white
        valor.font = UIFont.boldSystemFont(ofSize: 17)
        valor.text = ("$")+" 123.456.78"
        
        return valor
    }()
    
    lazy var valorMes:UILabel = {
        let valor = UILabel()
        valor.translatesAutoresizingMaskIntoConstraints = false
        valor.textColor = .white
        valor.font = UIFont.boldSystemFont(ofSize: 17)
        valor.text = ("$")+" 123.456.78"
        
        return valor
    }()
    
    lazy var valorAno:UILabel = {
        let valor = UILabel()
        valor.translatesAutoresizingMaskIntoConstraints = false
        valor.textColor = .white
        valor.font = UIFont.boldSystemFont(ofSize: 17)
        valor.text = ("$")+" 123.456.78"
        
        return valor
    }()

}
