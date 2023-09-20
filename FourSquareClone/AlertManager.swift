//
//  AlertManager.swift
//  FourSquareClone
//
//  Created by Çağan Bıçakçı on 19.09.2023.
//

import UIKit

class AlertManager : UIViewController {
    
    func showAlertDialog(context: UIViewController, title: String?, message: String?){
       let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
       let actionButton = UIAlertAction(title: "OK", style: .default)
       alert.addAction(actionButton)
       context.present(alert, animated: true)
   }
    
}
