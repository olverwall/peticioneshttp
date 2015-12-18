//
//  ViewController.swift
//  Isbn
//
//  Created by olver on 16/12/15.
//  Copyright (c) 2015 olver. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var busqueda: UISearchBar!
    
    @IBOutlet weak var resultado: UITextView!
    
    var busco:String = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func sincrono (ISBN: String) -> String {
        let urlopen = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
        
        let url = NSURL(string: urlopen+ISBN)
        
        let datos : NSData? = NSData(contentsOfURL: url!)
        
        if (datos == nil) { return "Error en la búsqueda: no se ha recibido respuesta de "+String(_cocoaString: url!)}
        
        let resultado = NSString(data: datos!, encoding:  NSUTF8StringEncoding)
        
        print (resultado)
        return resultado! as String
    }
    func asincrono (buscado:String){
        let urlopen = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
        let url = NSURL(string: urlopen+buscado);
        
        //let sesion = NSURLSession.sharedSession()
        
        //let bloque = {(datos: NSData?, resp : NSURLResponse?, error : NSError?)->Void in
        //let texto = NSString(data: datos!, encoding: NSUTF8StringEncoding)
            
         //   self.resultado.text = texto! as String;
        //}
       // let dt = sesion.dataTaskWithURL(url!, completionHandler: bloque)
        //dt?.resume()
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            if error != nil {
                print(error.localizedDescription)
            } else {
                var result = NSString(data: data, encoding:
                    NSUTF8StringEncoding)
                print(result)
                //self.resultado.text = result! as String
            }
            
            
        }
        
        task.resume()
    }
    @IBAction func limpiar(sender: AnyObject) {
        resultado.text = "Esperando....";
        busqueda.text = "";
    }
    @IBAction func buscar(sender: AnyObject) {
        busco = busqueda.text!;
        //asincrono(busco);
        resultado.text = sincrono(busco)
    }

}

