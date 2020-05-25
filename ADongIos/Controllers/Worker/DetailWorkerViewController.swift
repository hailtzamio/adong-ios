//
//  DetailLorryViewController.swift
//  ADongPr
//
//  Created by Cuongvh on 5/21/20.
//  Copyright © 2020 zamio. All rights reserved.
//

import UIKit

class DetailWorkerViewController: BaseViewController {
    var id = 0
    var item:Worker? = nil
    @IBOutlet weak var header: NavigationBar!
    var data = [Information]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        popupHandle() 

    
        getData()
    }
    
    func setupHeader() {
        header.title = "Chi Tiết"
        header.leftAction = {
            self.navigationController?.popViewController(animated: true)
        }
        
        header.rightAction = {
//            if let vc = UIStoryboard.init(name: "Product", bundle: Bundle.main).instantiateViewController(withIdentifier: "UpdateProductViewController") as? UpdateProductViewController {
//                vc.data = self.item
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
        }
        
        header.changeUpdateIcon()
    }
    
    func popupHandle() {
        okAction = {
            self.showLoading()
            APIClient.removeWorker(id: self.id) { result in
                self.stopLoading()
                switch result {
                case .success(let response):
                    if (response.status == 1) {
                        self.goBack()
                    }
                    self.showToast(content: response.message ?? "")
                    break
                    
                case .failure(let error):
                    self.showToast(content: error.localizedDescription)
                }
            }
        }
        
    }
    
    func getData() {
        showLoading()
        APIClient.getWorker(id: id) { result in
            self.stopLoading()
            switch result {
            case .success(let response):
                
                if let value = response.data  {
                    print(value.address)
                    self.item = value
                    return
                } else {
                    self.showToast(content: response.message!)
                }
                
            case .failure(let error):
                  self.showToast(content: error.localizedDescription)
            }
        }
    }
    
    
    
    @IBAction func remove(_ sender: Any) {
        showYesNoPopup(title: "Xóa", message: "Chắc chắn xóa?")
    }
}


