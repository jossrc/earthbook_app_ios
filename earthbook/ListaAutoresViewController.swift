//
//  ListaAutoresViewController.swift
//  earthbook
//
//  Created by CARLOS LOZANO ARANCIAGA on 7/2/22.
//

import UIKit
import Alamofire

class ListaAutoresViewController: UITableViewController, EarthbookAccion {
    func guardar(autor: JSAutor, idAutor: Int) {
        print("Hola")
    }

    
    private var listaAutores : [JSAutor] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        obtenerAutores()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    public func obtenerAutores(){
        let url = "https://bdearthbook.herokuapp.com/api/autor/listar"
                
                AF.request(url).response{
                    response in
                    switch response.result{
                    case .failure(let error) :
                        print("Error \(error)")
                    case .success(let info) :
                        if let info = info{
                            do{
                                let jsAutor = try JSONDecoder().decode([JSAutor].self, from: info)
                                
                                self.listaAutores = jsAutor
                                self.tableView.reloadData()
                                
                                
                                
                            }catch{
                               let alert = UIAlertController(title: "Informacion", message: "Error al decodificar", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                            }
                        }else{
                            let alert = UIAlertController(title: "Informacion", message: "No existe información", preferredStyle: .alert)
                             alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
                             self.present(alert, animated: true, completion: nil)
                        }
                        break
                    }
                }
        
    }
    
    @IBAction func RefrescarAutor(_ sender: Any) {
        obtenerAutores()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listaAutores.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellAutor", for: indexPath) as! AutorViewCell

        let autor = listaAutores[indexPath.row]

        cell.lblIdAutor.text = "\(autor.id)"
        cell.lblNombreAutor.text = autor.nombreCompleto
   
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinoGuardar = segue.destination as? CrudAutorViewController {
            destinoGuardar.listener = self
            if let celda = sender as? UITableViewCell {
                if let indexPath = self.tableView.indexPath(for: celda) {
                    print("Longitud Autores: \(listaAutores.count)")
                    print("Index path: \(indexPath)")
                    print("Index path row: \(indexPath.row)")
                    let contactoSelect = listaAutores[indexPath.row]
                    destinoGuardar.autor = contactoSelect
                    destinoGuardar.idAutor = contactoSelect.id
                    
                }
                
            }
        }
     
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
