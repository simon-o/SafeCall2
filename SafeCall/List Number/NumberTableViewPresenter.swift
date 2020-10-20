//
//  NumberTableViewPresenter.swift
//  SafeCall
//
//  Created by Antoine Simon on 20/10/2020.
//

import Combine

protocol NumberTableViewPresenterProtocol {
    func attach(VC: NumberTableViewControllerProtocol)
    func viewDidLoad()
}

final class NumberTableViewPresenter {
    private let service: NumberServiceProtocol
    private weak var vc: NumberTableViewControllerProtocol?
    
    private let subject = PassthroughSubject<[Numbers], Error>()
    
    init(service: NumberServiceProtocol) {
        self.service = service
    }
}

extension NumberTableViewPresenter: NumberTableViewPresenterProtocol {
    func viewDidLoad() {
        service.fetchNumbersList(file: "listPhone", suscriber: subject).sink { (error) in
            print(error)
        } receiveValue: { (numberList) in
            
        }
    }
    
    func attach(VC: NumberTableViewControllerProtocol) {
        self.vc = VC
    }
}
