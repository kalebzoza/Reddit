//
//  ErrorActionSheetExtenstion.swift
//  Reddit
//
//  Created by Kaleb  Carrizoza on 9/23/20.
//

import Foundation
import UIKit

extension UIViewController {
    
    func presentErrorToUser(localizedError: LocalizedError) {
        let alertController = UIAlertController(title: "Error", message: localizedError.errorDescription, preferredStyle: .actionSheet)
        
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
       
        //calls the add action button
        alertController.addAction(dismissAction)
        present(alertController, animated: true)
    }
  
}
