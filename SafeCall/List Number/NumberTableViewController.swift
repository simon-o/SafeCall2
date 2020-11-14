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
            // To improve that I should try to do the assign in the cell directly on the label.text
            //https://swifthowto.blogspot.com/2019/11/use-swift-combine-to-load.html
            // work only for thing that needs to be downloaded after the list because we need the numbers of product to know the number of cell to diplay first 
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
        
        tableView.register(NumbersTableViewCell.self, forCellReuseIdentifier: "CellID")

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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellID") as? NumbersTableViewCell else { return UITableViewCell() }
        presenter.setUp(cell: cell, index: indexPath.row)
        return cell
    }
}

extension NumberTableViewController: NumberTableViewControllerProtocol {
    func setListNumber(list: [Numbers]) {
        listNumbers = list
    }
}
