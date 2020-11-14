//
//  NumbersTableViewCell.swift
//  SafeCall
//
//  Created by Antoine Simon on 14/11/2020.
//

import UIKit

protocol NumbersTableViewCellProtocol {
    func set(countryName: String)
}

class NumbersTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension NumbersTableViewCell: NumbersTableViewCellProtocol {
    func set(countryName: String) {
        self.textLabel?.text = countryName
    }
}
