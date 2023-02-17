//
//  ConsolesManager.swift
//  My Games
//
//  Created by Vinicius Loss on 14/02/23.
//

import CoreData

class ConsolesManager {
    static let shared = ConsolesManager()
    var consoles: [Console] = []
    
    func loadConsoles(with context: NSManagedObjectContext){
        let fechRequest: NSFetchRequest<Console> = Console.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fechRequest.sortDescriptors = [sortDescriptor]
        
        do {
            // usado para quantidades pequedas de listagem de dados
            consoles = try context.fetch(fechRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteConsole(index: Int, context: NSManagedObjectContext){
        let console = consoles[index]
        context.delete(console)
        
        do {
            try context.save()
            consoles.remove(at: index)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private init (){
    }
}
