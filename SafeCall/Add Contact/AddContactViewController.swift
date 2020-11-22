//
//  AddContactViewController.swift
//  SafeCall
//
//  Created by Antoine Simon on 22/11/2020.
//

import UIKit

protocol AddContactViewControllerProtocol: NSObject {
    func getName1() -> String
    func getName2() -> String
    func getPhone1() -> String
    func getPhone2() -> String
    
    func set(name1: String)
    func set(name2: String)
    func set(phone1: String)
    func set(phone2: String)
}

final class AddContactViewController: UIViewController {
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var name1: UITextField!
    @IBOutlet weak var phone1: UITextField!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var name2: UITextField!
    @IBOutlet weak var phone2: UITextField!
    
    private let presenter: AddContactPresenterProtocol
    
    
    init(presenter: AddContactPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: String(describing: AddContactViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        presenter.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillClose()
    }
    
    private func setUp() {
        label1.text = "Contact details"
        label2.text = "Contact details"
        
        name1.attributedPlaceholder = NSAttributedString(string: "Name Contact", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        name2.attributedPlaceholder = NSAttributedString(string: "Name Contact", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        name1.textColor = .white
        name2.textColor = .white
        
        phone1.attributedPlaceholder = NSAttributedString(string: "Phone Number", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        phone2.attributedPlaceholder = NSAttributedString(string: "Phone Number", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        phone1.textColor = .white
        phone2.textColor = .white
    }
}

extension AddContactViewController: AddContactViewControllerProtocol {
    func set(name1: String) {
        self.name1.text = name1
    }
    
    func set(name2: String) {
        self.name2.text = name2
    }
    
    func set(phone1: String) {
        self.phone1.text = phone1
    }
    
    func set(phone2: String) {
        self.phone2.text = phone2
    }
    
    func getName1() -> String {
        return name1.text ?? ""
    }
    
    func getName2() -> String {
        return name2.text ?? ""
    }
    
    func getPhone1() -> String {
        return phone1.text ?? ""
    }
    
    func getPhone2() -> String {
        return phone2.text ?? ""
    }
    
    
}
