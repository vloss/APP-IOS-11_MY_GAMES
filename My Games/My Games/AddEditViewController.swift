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
    
    // lazy só constroi uma classe quando for utiliza-la
    lazy var pickerView: UIPickerView = {
       let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    var consolesManager = ConsolesManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        //tfTitle.resignFirstResponder()
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        toolbar.tintColor = UIColor(named: "main")
        
        let btCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        let btDone  = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        let blFlexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [btCancel, blFlexibleSpace, btDone]
        
        
        tfConsole.inputView = pickerView
        tfConsole.inputAccessoryView = toolbar
    }
    
    @objc func cancel(){
        tfConsole.resignFirstResponder()
    }
    
    @objc func done(){
        
        var index = pickerView.selectedRow(inComponent: 0)
        
        tfConsole.text = consolesManager.consoles[index].name
        
        cancel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        consolesManager.loadConsoles(with: context)
    }
    
    @IBAction func addEditGame(_ sender: UIButton) {
        // valida se já existe um game é pq é edição
        if game == nil {
            game = Game(context: context)
        }
        
        game.title = tfTitle.text
        game.releaseDate = dpReleaseDate.date
        
        if !tfConsole.text!.isEmpty {
            let console = consolesManager.consoles[pickerView.selectedRow(inComponent: 0)]
            game.console = console
        }
        
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

extension AddEditViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    // Número de linhas exibidas.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return consolesManager.consoles.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let console = consolesManager.consoles[row]
        return console.name
    }
}
