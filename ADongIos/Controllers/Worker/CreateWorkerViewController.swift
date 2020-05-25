//
//  CreateWorkerViewController.swift
//  ADongIos
//
//  Created by Cuongvh on 5/24/20.
//  Copyright © 2020 zamio. All rights reserved.
//

import UIKit

class CreateWorkerViewController: BaseViewController {

    @IBOutlet weak var header: NavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupHeader()
    }
    

 func setupHeader() {
    header.title = "Tạo Công Nhân"
    header.leftAction = {
        self.navigationController?.popViewController(animated: true)
    }
    
    header.rightAction = {
//        if let vc = UIStoryboard.init(name: "Product", bundle: Bundle.main).instantiateViewController(withIdentifier: "UpdateProductViewController") as? UpdateProductViewController {
//            vc.data = self.item
//            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}
