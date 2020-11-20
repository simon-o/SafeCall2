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
    func setUp(cell: NumbersTableViewCellProtocol, index: Int)
    func filterContentForSearchText(_ searchText: String)
    func getCount() -> Int
    func setUpEmergencyView(index: Int) -> EmergencyViewController
}

final class NumberTableViewPresenter {
    private let service: NumberServiceProtocol
    private weak var vc: NumberTableViewControllerProtocol?
    var filteredCountry: [Numbers] = []
    @Published private var listNumbers: [Numbers]?
    
    private let subject = PassthroughSubject<[Numbers], Never>()
    
    init(service: NumberServiceProtocol) {
        self.service = service
    }
}

extension NumberTableViewPresenter: NumberTableViewPresenterProtocol {
    func setUpEmergencyView(index: Int) -> EmergencyViewController {
        return EmergencyViewController(country: filteredCountry[index].Country.Name,
                                       ambulance: filteredCountry[index].Ambulance,
                                       fire: filteredCountry[index].Fire,
                                       police: filteredCountry[index].Police)
    }
    
    func getCount() -> Int{
        return filteredCountry.count
    }
    
    func setUp(cell: NumbersTableViewCellProtocol, index: Int) {
            cell.set(countryName: filteredCountry[index].Country.Name)
            cell.set(codeName: filteredCountry[index].Country.ISOCode + " / " + filteredCountry[index].Country.ISONumeric)
    }
    
    func viewDidLoad() {
        let anyCancellable = subject.sink(receiveValue: { value in
            self.listNumbers = value
            self.filteredCountry = value
            self.vc?.reloadData()
        })
        
        service.fetchNumbersList(file: "listPhone", subject: subject)
    }
    
    func attach(VC: NumberTableViewControllerProtocol) {
        self.vc = VC
    }
    
    func filterContentForSearchText(_ searchText: String) {
        if searchText.isEmpty {
            if let list = listNumbers {
                filteredCountry = list
                return
            }
        }
        if let list = listNumbers {
            filteredCountry = list.filter { (numbers: Numbers) -> Bool in
                return numbers.Country.Name.lowercased().contains(searchText.lowercased())
            }
        }
    }
}
