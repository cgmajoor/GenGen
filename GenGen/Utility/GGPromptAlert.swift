//
//  GGPromptAlert.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 03/04/2023.
//

import UIKit

class GGPromptAlert {
    static func createAlert(title: String,
                            message: String?,
                            in vc: UIViewController,
                            onAdd: @escaping ((String?) -> Void)) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        var textField = UITextField()
        alertController.addTextField { textField = $0 }

        let addAction = UIAlertAction(title: Texts.promptAlertAddActionTitle, style: .default) { _ in
            onAdd(textField.text)
        }
        let cancelAction = UIAlertAction(title: Texts.promptAlertCancelActionTitle, style: .default)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)

        vc.showDetailViewController(alertController, sender: vc)
    }
}
