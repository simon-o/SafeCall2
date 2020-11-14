//
//  NumberTableViewPresenter.swift
//  SafeCall
//
//  Created by Antoine Simon on 20/10/2020.
//

import Foundation
import Combine

protocol NumberTableViewPresenterProtocol {
    func attach(VC: NumberTableViewControllerProtocol)
    func viewDidLoad()
}

final class NumberTableViewPresenter {
    private let service: NumberServiceProtocol
    private weak var vc: NumberTableViewControllerProtocol?
    @Published private var listNumbers: [Numbers]?
    
    private let subject = PassthroughSubject<[Numbers], Never>()
    
    init(service: NumberServiceProtocol) {
        self.service = service
    }
}

extension NumberTableViewPresenter: NumberTableViewPresenterProtocol {
    func viewDidLoad() {
        
        let anyCancellable = subject.sink(receiveValue: { value in
            self.listNumbers = value
            self.vc?.setListNumber(list: value)
        })
        
        service.fetchNumbersList(file: "listPhone", subject: subject)
    }
    
    func attach(VC: NumberTableViewControllerProtocol) {
        self.vc = VC
    }
}
