import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var txtContrasena: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let email = txtEmail.text ?? "noemail@gmail.com"
        let password = txtContrasena.text ?? "error"
        // 
            let url = "https://bdearthbook.herokuapp.com/api/usuarios/login/\(email)/\(password)"
            
            AF.request(url).response { response in
                switch response.result{
                case .failure(let error):
                    print("Error \(error)")
                    break
                case .success(let info):
                    if let info = info{
                        do{
                            let jsCodigo = try JSONDecoder().decode(JSLogin.self, from: info)
                            
                            let ok = jsCodigo.OK
                            
                            if ok == true {
                                // Redirija
                                //let resultadoVC = segue.destination as!
                                print("Funciona")
                                
                            } else {
                                let alert = UIAlertController(title: "Informacion", message: "Correo o clave incorrectos", preferredStyle: .alert)
                                 alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
                                 self.present(alert, animated: true, completion: nil)
                                return
                            }
                            
                            
                        } catch{
                            print("Error al codificar")
                            return
                        }
                    } else{
                        print("No se encontro informacion")
                        return
                    }
                    break
                }
            }
    }

}

