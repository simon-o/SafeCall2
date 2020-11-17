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
    func setUp(cell: NumbersTableViewCellProtocol, index: Int, isFiltering: Bool)
    func filterContentForSearchText(_ searchText: String)
    func getCount(isFiltering: Bool) -> Int
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
    func getCount(isFiltering: Bool) -> Int{
        return isFiltering ? filteredCountry.count : listNumbers?.count ?? 0
    }
    
    func setUp(cell: NumbersTableViewCellProtocol, index: Int, isFiltering: Bool) {
        let tmpList = isFiltering ? filteredCountry : listNumbers
        if let list = tmpList {
            cell.set(countryName: list[index].Country.Name)
            cell.set(codeName: list[index].Country.ISOCode + " / " + list[index].Country.ISONumeric)
        }
    }
    
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
    
    func filterContentForSearchText(_ searchText: String) {
        if let list = listNumbers {
            filteredCountry = list.filter { (numbers: Numbers) -> Bool in
                return numbers.Country.Name.lowercased().contains(searchText.lowercased())
            }
        }
    }
}
