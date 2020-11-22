//
//  EmergencyViewController.swift
//  SafeCall
//
//  Created by Antoine Simon on 15/11/2020.
//

import UIKit


final class EmergencyViewController: UIViewController {

    @IBOutlet weak var fireButton: UIButton!
    @IBOutlet weak var healthButton: UIButton!
    @IBOutlet weak var policeButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var contact2: UIButton!
    @IBOutlet weak var contact1: UIButton!
    
    private var police: Police
    private var ambulance: Ambulance
    private var fire: Fire
    
    private let defaults = UserDefaults.standard
    
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
       
        contact1.isHidden = true
        contact2.isHidden = true
        
        setUp()
    }
    
    private func setUp() {
        self.view.layer.cornerRadius = 10
        let listButton = [fireButton, healthButton, policeButton, contact2, contact1]
        for button in listButton {
            button?.layer.cornerRadius = 8
        }
        
        if let stringOne = defaults.string(forKey: "name1") {
            if !stringOne.isEmpty {
                contact1.setTitle(stringOne, for: .normal)
                contact1.isHidden = false
            }
        }
        if let stringTwo = defaults.string(forKey: "name2") {
            if !stringTwo.isEmpty {
                contact2.setTitle(stringTwo, for: .normal)
                contact2.isHidden = false
            }
        }
    }
    
    private func call(number: String) {
        guard let phone = URL(string: "tel://" + number) else { return }
        UIApplication.shared.open(phone)
    }
    
    @IBAction func contact2Pressed(_ sender: Any) {
        if let stringOne = defaults.string(forKey: "phone2") {
            call(number: stringOne)
        }
    }
    
    @IBAction func contact1Pressed(_ sender: Any) {
        if let stringOne = defaults.string(forKey: "phone1") {
            call(number: stringOne)
        }
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
