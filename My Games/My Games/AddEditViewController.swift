//
//  AddEditViewController.swift
//  My Games
//
//  Created by Vinicius Loss on 10/02/23.
//

import UIKit

class AddEditViewController: UIViewController {
    
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfConsole: UITextField!
    @IBOutlet weak var dpReleaseDate: UIDatePicker!
    @IBOutlet weak var btAddEdit: UIButton!
    @IBOutlet weak var btCover: UIButton!
    @IBOutlet weak var ivCover: UIImageView!
    
    var game: Game!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tfTitle.resignFirstResponder()
    }
    
    @IBAction func addEditGame(_ sender: UIButton) {
        // valida se já existe um game é pq é edição
        if game == nil {
            game = Game(context: context)
        }
        
        game.title = tfTitle.text
        game.releaseDate = dpReleaseDate.date
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        
        // Volta para tela anterior
        navigationController?.popViewController(animated: true)
    }
    
    
    // Toda vez que é tocado em qualquer lugar na tela
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Fecha o teclado
        view.endEditing(true)
        //setValues()
    }
    
    
    @IBAction func addEditCover(_ sender: UIButton) {
        
    }
}
