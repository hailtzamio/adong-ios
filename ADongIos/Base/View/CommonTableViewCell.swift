//
//  CommonTableViewCell.swift
//  ADongPr
//
//  Created by Cuongvh on 5/21/20.
//  Copyright © 2020 zamio. All rights reserved.
//

import UIKit
import Kingfisher

class CommonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lb1: UILabel!
    
    @IBOutlet weak var lb2: UILabel!
    
    @IBOutlet weak var lb3: UILabel!
    
    @IBOutlet weak var imvAva: UIImageView!
    let imageDf = UIImage(named: "default")
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    func setData(data:Lorry) {
        lb1.text = data.model
        lb2.text = data.brand
        lb3.text = data.plateNumber
    }
    
    func setDataProduct(data:Product) {
        lb1.text = data.name
        lb2.text = data.createdByFullName
        lb3.text = data.updatedTime
    }
    
    func setDataWorker(data:Worker) {
        lb1.text = data.userFullName
        lb2.text = data.createdByFullName
        lb3.text = data.updatedTime
        let url = URL(string: data.avatarUrl ?? "")
        
        imvAva.kf.setImage(with: url, placeholder: imageDf)
    }
}
