//
//  CrudAutorViewController.swift
//  earthbook
//
//  Created by CARLOS LOZANO ARANCIAGA on 7/2/22.
//

import UIKit
import Alamofire

class CrudAutorViewController: UIViewController {

    @IBOutlet weak var txtBiografia: UITextField!
    @IBOutlet weak var txtNombre: UITextField!
    
    var idAutor: Int? = -1
    var autor: JSAutor? = nil
    var listener: EarthbookAccion? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        if let autor = autor {
            idAutor = autor.id
            txtNombre.text = autor.nombreCompleto
            txtBiografia.text = autor.biografia
            
            print("Id autor: \(autor.id)")
            print("Nombre autor: \(autor.nombreCompleto)")
            print("Biografia autor: \(autor.biografia)")
        }
    }
    
    @IBAction func GuardarAutor(_ sender: Any) {
        guard let nombre = txtNombre.text, !nombre.isEmpty else {
            let alert = UIAlertController(title: "Informacion", message: "Debe ingresar un nombre de autor", preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
             self.present(alert, animated: true, completion: nil)
            return
        }
        guard let biografia = txtBiografia.text, !biografia.isEmpty else {
            let alert = UIAlertController(title: "Informacion", message: "Debe ingresar una biografia de autor", preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
             self.present(alert, animated: true, completion: nil)
            return
        }
        
        if idAutor == -1 || idAutor == nil{
            // NUEVO
            let autor: Parameters = ["nombre_completo":nombre,"biografia":biografia,"imagen":"https://res.cloudinary.com/dfuuywyk9/image/upload/v1621437436/l60Hf_megote.png","pais":["id":9999]]
                let headers: HTTPHeaders = ["Content-Type": "application/json"]
                print(autor)
            AF.request("https://bdearthbook.herokuapp.com/api/autor/agregar", method: .post, parameters: autor,encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse) in response.result}
                let alert = UIAlertController(title: "Informacion", message: "Se registro exitosamente", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
        }else{
            // ACTUALIZAR
            let autor: Parameters = ["id":idAutor,"nombre_completo":nombre,"biografia":biografia,"imagen":"https://res.cloudinary.com/dfuuywyk9/image/upload/v1621437436/l60Hf_megote.png","pais":["id":9999]]
                let headers: HTTPHeaders = ["Content-Type": "application/json"]
                print(autor)
            AF.request("https://bdearthbook.herokuapp.com/api/autor/actualizar", method: .put, parameters: autor,encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse) in response.result}
                let alert = UIAlertController(title: "Informacion", message: "Se actualizo exitosamente", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
        }
       
            
        
       
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
