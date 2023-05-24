//
//  TableViewCell.swift
//  Covid19
//
//  Created by SeongJae on 2021/11/12.
//  Copyright © 2021 comsoft. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    //tableView 안 요소들 연결
    @IBOutlet weak var area: UILabel!
    @IBOutlet weak var coronic: UILabel!
    @IBOutlet weak var treatment: UILabel!
    @IBOutlet weak var dead: UILabel!
    @IBOutlet weak var unlockdown: UILabel!
    @IBOutlet weak var rate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
