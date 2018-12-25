//
//  ViewControllerAlert.swift
//  StudioFinder
//
//  Created by Admin on 05.12.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // Show alert
    func showAlert(withTitle title: String, message msg: String) {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}
