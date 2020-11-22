//
//  AddContactPresenter.swift
//  SafeCall
//
//  Created by Antoine Simon on 22/11/2020.
//

import Foundation

protocol AddContactPresenterProtocol {
    func attach(VC: AddContactViewControllerProtocol)
    func viewDidLoad()
    func viewWillClose()
}

final class AddContactPresenter {
    private weak var vc: AddContactViewControllerProtocol?
    private  let defaults = UserDefaults.standard
    
    private func saveContacts() {
        defaults.set(vc?.getName1(), forKey: "name1")
        defaults.set(vc?.getPhone1(), forKey: "phone1")
        
        defaults.set(vc?.getName2(), forKey: "name2")
        defaults.set(vc?.getPhone2(), forKey: "phone2")
    }
    
    private func setContact() {
        if let stringOne = defaults.string(forKey: "name1") {
            vc?.set(name1: stringOne)
        }
        if let stringOne = defaults.string(forKey: "name2") {
            vc?.set(name2: stringOne)
        }
        if let stringOne = defaults.string(forKey: "phone1") {
            vc?.set(phone1: stringOne)
        }
        if let stringOne = defaults.string(forKey: "phone2") {
            vc?.set(phone2: stringOne)
        }
    }
}

extension AddContactPresenter: AddContactPresenterProtocol {
    func attach(VC: AddContactViewControllerProtocol) {
        self.vc = VC
    }
    
    func viewDidLoad() {
        setContact()
    }
    
    func viewWillClose() {
        saveContacts()
    }
}
