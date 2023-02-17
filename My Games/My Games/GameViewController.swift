//
//  GameViewController.swift
//  My Games
//
//  Created by Vinicius Loss on 10/02/23.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbConsole: UILabel!
    @IBOutlet weak var lbReleaseDate: UILabel!
    @IBOutlet weak var ivCover: UIImageView!
    
    var game: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Só quando a view é criada
//        lbTitle.text = game.title
//        lbConsole.text = game.console?.name
//        if let releaseDate = game.releaseDate{
//            let formatter = DateFormatter()
//            formatter.dateStyle = .long
//            formatter.locale = Locale(identifier: "pt-BR")
//            lbReleaseDate.text = "Lançamento: " + formatter.string(from: releaseDate)
//        }
//        if let image = game.cover as? UIImage{
//            ivCover.image = image
//        } else {
//            ivCover.image = UIImage(named: "noCoverFull")
//        }
    }
    
    // Para mostrar toda vez que a tela aparecer
    override func viewWillAppear(_ animated: Bool) {
        
        // Só quando a view é criada
        lbTitle.text = game.title
        lbConsole.text = game.console?.name
        if let releaseDate = game.releaseDate{
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            formatter.locale = Locale(identifier: "pt-BR")
            lbReleaseDate.text = "Lançamento: " + formatter.string(from: releaseDate)
        }
        if let image = game.cover as? UIImage{
            ivCover.image = image
        } else {
            ivCover.image = UIImage(named: "noCoverFull")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddEditViewController
        
        // Repassa o game da tela atual para a próxima tela
        vc.game = game
    }
}
