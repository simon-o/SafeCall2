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
    
    var police: Police
    var ambulance: Ambulance
    var fire: Fire
    
    init(country: String, ambulance: Ambulance, fire: Fire, police: Police ) {
        self.police = police
        self.ambulance = ambulance
        self.fire = fire
        super.init(nibName: String(describing: EmergencyViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setUp()
    }
    
    private func setUp() {
        self.view.layer.cornerRadius = 10
        let listButton = [fireButton, healthButton, policeButton]
        for button in listButton {
            button?.layer.cornerRadius = 8
        }
    }
    
    private func call(number: String) {
        guard let phone = URL(string: "tel://" + number) else { return }
        UIApplication.shared.open(phone)
    }
    
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func firePressed(_ sender: Any) {
        if let phone = fire.All[0] {
            call(number: phone)
        }
    }
    
    @IBAction func ambulancePressed(_ sender: Any) {
        if let phone = fire.All[0] {
            call(number: phone)
        }
    }
    
    @IBAction func policePressed(_ sender: Any) {
        if let phone = fire.All[0] {
            call(number: phone)
        }
    }
}
