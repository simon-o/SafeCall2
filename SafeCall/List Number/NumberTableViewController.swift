//
//  NumberTableViewController.swift
//  SafeCall
//
//  Created by Antoine Simon on 20/10/2020.
//

import UIKit

protocol NumberTableViewControllerProtocol: NSObject {
    func setListNumber(list: [Numbers])
}

final class NumberTableViewController: UITableViewController {
    private let presenter: NumberTableViewPresenterProtocol
    @Published private var listNumbers: [Numbers]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    init(presenter: NumberTableViewPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: String(describing: NumberTableViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.attach(VC: self)
        presenter.viewDidLoad()
        
        
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listNumbers?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if let tmp = listNumbers {
            cell.textLabel?.text = tmp[indexPath.row].Country.Name
        }
        
        return cell
    }
}

extension NumberTableViewController: NumberTableViewControllerProtocol {
    func setListNumber(list: [Numbers]) {
        listNumbers = list
    }
}
