//
//  ListaCategoriasViewController.swift
//  earthbook
//
//  Created by CARLOS LOZANO ARANCIAGA on 7/1/22.
//

import UIKit
import Alamofire

class ListaCategoriasViewController: UITableViewController {

    // Por el momento arr de string
    private var listaCategorias : [JSCategoria] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        obtenerCategoria()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    private func obtenerCategoria(){
        let url = "https://bdearthbook.herokuapp.com/api/categorias/listar"
                
                AF.request(url).response{
                    response in
                    switch response.result{
                    case .failure(let error) :
                        print("Error \(error)")
                    case .success(let info) :
                        if let info = info{
                            do{
                                let jsCategoria = try JSONDecoder().decode([JSCategoria].self, from: info)
                                
                                self.listaCategorias = jsCategoria
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
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listaCategorias.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellcategoria", for: indexPath) as! CategoriaViewCell
        
        let categoria = listaCategorias[indexPath.row]

        cell.txtIdCategoria.text = "\(categoria.id)"
        cell.txtNombreCategoria.text = categoria.nombre
        return cell
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
