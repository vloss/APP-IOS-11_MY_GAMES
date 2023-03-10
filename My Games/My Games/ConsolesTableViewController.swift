//
//  ConsolesTableViewController.swift
//  My Games
//
//  Created by Vinicius Loss on 10/02/23.
//

import UIKit

class ConsolesTableViewController: UITableViewController {
    
    var consoleManager = ConsolesManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        loadConsoles()

    }
    
    func loadConsoles(){
        consoleManager.loadConsoles(with: context)
        tableView.reloadData()
    }

    @IBAction func addConsole(_ sender: UIBarButtonItem) {
        showAlert(with: nil)
    }
    
    // console definido como optional, pois se não existir segnifica que é novo, se existir é pq é edição.
    func showAlert(with console: Console?){
        let title = console == nil ? "Adicionar" : "Editar"
        let alert = UIAlertController(title: title + " plataforma", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Nome da Plataforma"
            
            if let name = console?.name{
                textField.text = name
            }
        }
        alert.addAction(UIAlertAction(title: title, style: .default, handler: { (action) in
            // Atribui a variavel console o objeto recebido por parametro no metodo
            // Utilizando operador de coalescência nula, para instanciar um novo objeto caso
            let console = console ?? Console(context: self.context)
            console.name = alert.textFields?.first?.text
            do {
                try self.context.save()
                self.loadConsoles()
            } catch {
                print(error.localizedDescription)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        alert.view.tintColor = UIColor(named: "second")
        present(alert, animated: true)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return consoleManager.consoles.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let console =  consoleManager.consoles[indexPath.row]
        showAlert(with: console)
        tableView.deselectRow(at: indexPath, animated: false)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Carrega o registro para atribuir a cell
        let console = consoleManager.consoles[indexPath.row]
        
        cell.textLabel?.text = console.name

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            consoleManager.deleteConsole(index: indexPath.row, context: context)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
