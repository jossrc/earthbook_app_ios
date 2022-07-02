//
//  CrudLibroViewController.swift
//  earthbook
//
//  Created by CARLOS LOZANO ARANCIAGA on 7/2/22.
//

import UIKit
import Alamofire

class CrudLibroViewController: UIViewController {

    @IBOutlet weak var txtTitulo: UITextField!
    @IBOutlet weak var txtEditorial: UITextField!
    @IBOutlet weak var txtDescripcion: UITextField!
    var idLibro: Int? = -1
    var libro: JSLibro? = nil
    var listener: EarthbookAccionLibro? = nil
    
    var paginas = 0
    var imagen = ""
    
    /*
     let id: Int
         let titulo, descripcion: String
         let paginas: Int
         let imagen: String
         let autor: Autor
         let editorial: String
         let categoria: CategoriaClass
         let isbn, sku: String     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let libro = libro {
            idLibro = libro.id
            
            txtTitulo.text = libro.titulo
            txtEditorial.text = libro.editorial
            txtDescripcion.text = libro.descripcion

        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func guardarLibro(_ sender: Any) {
        guard let titulo = txtTitulo.text, !titulo.isEmpty else {
            let alert = UIAlertController(title: "Informacion", message: "Debe ingresar un titulo de libro", preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
             self.present(alert, animated: true, completion: nil)
            return
        }
        guard let editorial = txtEditorial.text, !editorial.isEmpty else {
            let alert = UIAlertController(title: "Informacion", message: "Debe ingresar una editorial de libro", preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
             self.present(alert, animated: true, completion: nil)
            return
        }
        guard let descripcion = txtDescripcion.text, !descripcion.isEmpty else {
            let alert = UIAlertController(title: "Informacion", message: "Debe ingresar una descripcion de libro", preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
             self.present(alert, animated: true, completion: nil)
            return
        }
        
        
        if idLibro == -1 || idLibro == nil{
            // NUEVO
            let libro: Parameters = ["titulo": titulo,
                                     "descripcion": descripcion,
                                     "paginas": 100,
                                     "imagen": "https://res.cloudinary.com/dvkoqncw8/image/upload/v1656301723/book_20placeholder_inwbld.png",
                                     "autor": [
                                         "id": 9999,
                                        "pais": [
                                            "id": 9999
                                        ]
                                     ],
                                     "editorial": editorial,
                                     "categoria": [
                                         "id": 9999
                                     ],
                                     "isbn": "9999999999999",
                                     "sku": "9999999999999"]
                let headers: HTTPHeaders = ["Content-Type": "application/json"]
                print(libro)
            AF.request("https://bdearthbook.herokuapp.com/api/libros/agregar", method: .post, parameters: libro,encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse) in response.result}
                let alert = UIAlertController(title: "Informacion", message: "Se registro exitosamente", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
        }else{
            // ACTUALIZAR
            let libro: Parameters = [
                                     "id": idLibro,
                                     "titulo": titulo,
                                     "descripcion": descripcion,
                                    "paginas": self.libro?.paginas,
                                    "imagen": self.libro?.imagen,
                                     "autor": [
                                        "id": self.libro?.autor.id,
                                        "pais": [
                                            "id": 9999
                                        ]
                                     ],
                                     "editorial": editorial,
                                     "categoria": [
                                        "id": self.libro?.categoria.id
                                     ],
                                    "isbn": self.libro?.isbn,
                                    "sku": self.libro?.sku]
                let headers: HTTPHeaders = ["Content-Type": "application/json"]
                print(libro)
            AF.request("https://bdearthbook.herokuapp.com/api/libros/actualizar", method: .put, parameters: libro,encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse) in response.result}
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
