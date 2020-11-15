//
//  EmergencyViewController.swift
//  SafeCall
//
//  Created by Antoine Simon on 15/11/2020.
//

import UIKit


class EmergencyViewController: UIViewController {

    @IBOutlet weak var fireButton: UIButton!
    @IBOutlet weak var healthButton: UIButton!
    @IBOutlet weak var policeButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layer.cornerRadius = 10
        
        let listButton = [fireButton, healthButton, policeButton]
        
        for button in listButton {
            button?.layer.cornerRadius = 8
        }
    }
    
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
