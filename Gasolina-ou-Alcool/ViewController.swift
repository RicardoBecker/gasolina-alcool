//
//  ViewController.swift
//  Gasolina-ou-Alcool
//
//  Created by Ricardo Becker on 10/10/19.
//  Copyright © 2019 Ricardo Becker. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var resultadoLegenda: UILabel!
    @IBOutlet weak var precoAlcool: UITextField!
    @IBOutlet weak var precoGasolina: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        precoAlcool.smartInsertDeleteType = UITextSmartInsertDeleteType.no
        precoAlcool.delegate = self
        
        precoGasolina.smartInsertDeleteType = UITextSmartInsertDeleteType.no
        precoGasolina.delegate = self
    }
    
    func textField(_ precoAlcool: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = precoAlcool.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 5
    }
    
    func textField2(_ precoGasolina: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = precoGasolina.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 5
    }

    
    @IBAction func limpaCampos(_ sender: Any) {
        precoAlcool.text = ""
        precoGasolina.text = ""
    }    
    
    @IBAction func calcularGasolina(_ sender: Any) {
        if let precoAlcool = precoAlcool.text {
            if let precoGasolina = precoGasolina.text {
                // validar valores digitados
                let validaCampos = self.validarCampos(precoAlcool: precoAlcool, precoGasolina: precoGasolina)
                
                if validaCampos {
                    
                    self.calculaValor(precoAlcool: precoAlcool, precoGasolina: precoGasolina)
                    
                }else{
                    resultadoLegenda.text = "Digite os valores para calcular"
                }
            }
        }
        
    }
    
    func calculaValor(precoAlcool: String, precoGasolina: String) {
        if let valorAlcool = Double(precoAlcool){
            if let valorGasolina = Double(precoGasolina){
                let resultado = valorAlcool / valorGasolina
                if resultado < 0.7 {
                   resultadoLegenda.text = "Abasteça com alcool"
                }else{
                    resultadoLegenda.text = "Abasteça com Gasolina"
                }
            }
            
        }
    }
    
    func validarCampos(precoAlcool: String, precoGasolina: String) -> Bool {
        var camposValidados = true
        
        if precoAlcool.isEmpty{
            camposValidados = false
        }
        
        if precoGasolina.isEmpty{
            camposValidados = false
        }
        
        return camposValidados
    }


}

