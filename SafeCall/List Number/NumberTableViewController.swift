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
    private let searchController = UISearchController(searchResultsController: nil)
    var isFiltering: Bool {
      return searchController.isActive && !(searchController.searchBar.text?.isEmpty ?? true)
    }
    @Published private var listNumbers: [Numbers]? {
        didSet {
            // To improve that I should try to do the assign in the cell directly on the label.text
            //https://swifthowto.blogspot.com/2019/11/use-swift-combine-to-load.html
            // work only for thing that needs to be downloaded after the list because we need the numbers of product to know the number of cell to diplay first 
            self.tableView.reloadData()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
        
        setUp()
        presenter.attach(VC: self)
        presenter.viewDidLoad()
    }
    
    private func setUp() {
        tableView.register(UINib(nibName: String(describing: NumbersTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: NumbersTableViewCell.self))
        tableView.backgroundColor = UIColor(named: "NumbersListBackgroundTavleView")
        
        let backgroundView = UIView.init(frame: tableView.bounds)
        backgroundView.backgroundColor = UIColor(named: "NumbersListBackgroundTavleView")
        tableView.backgroundView = backgroundView
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Country"
        searchController.searchBar.searchTextField.textColor = UIColor(named: "SecondText")
        searchController.searchBar.tintColor = UIColor(named: "MainText")
        searchController.searchBar.barTintColor = UIColor(named: "NumbersListCell")
        
        self.tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NumbersTableViewCell.self)) as? NumbersTableViewCell else { return UITableViewCell() }
        presenter.setUp(cell: cell, index: indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = EmergencyViewController()
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = UIModalPresentationStyle.custom
        
        self.present(vc, animated: true, completion: nil)
        
    }
}

extension NumberTableViewController: NumberTableViewControllerProtocol {
    func setListNumber(list: [Numbers]) {
        listNumbers = list
    }
}

extension NumberTableViewController : UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfSizePresentationController(presentedViewController: presented, presenting: presenting)
    }
}

extension NumberTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        presenter.filterContentForSearchText(searchBar.text ?? "")
        tableView.reloadData()
        
    }
}
