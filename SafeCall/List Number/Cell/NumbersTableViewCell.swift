//
//  NumbersTableViewCell.swift
//  SafeCall
//
//  Created by Antoine Simon on 14/11/2020.
//

import UIKit

protocol NumbersTableViewCellProtocol {
    func set(countryName: String)
    func set(codeName: String)
}

class NumbersTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 10
        containerView.backgroundColor = UIColor(named: "NumbersListCell")
        contentView.backgroundColor = UIColor(named: "NumbersListBackgroundTavleView")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension NumbersTableViewCell: NumbersTableViewCellProtocol {
    func set(countryName: String) {
        countryLabel.text = countryName
    }
    
    func set(codeName: String) {
        codeLabel.text = codeName
    }
}
