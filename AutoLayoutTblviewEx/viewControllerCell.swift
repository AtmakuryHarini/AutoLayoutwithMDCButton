//
//  viewControllerCell.swift
//  AutoLayoutTblviewEx
//
//  Created by Atmakury Harish on 5/7/18.
//  Copyright © 2018 Atmakury Harini. All rights reserved.
//

import UIKit

class viewControllerCell: UITableViewCell {

    
    @IBOutlet weak var cellLabel1: UILabel!
    @IBOutlet weak var cellLabel2: UILabel!
    @IBOutlet weak var cellLabel3: UILabel!
    //----------------------------------------------------------

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    //----------------------------------------------------------

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
         
        // Configure the view for the selected state
    }
   //----------------------------------------------------------
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Cell dimension constraints code
       
    }
   
    
    //----------------------------------------------------------

}
