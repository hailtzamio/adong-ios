//
//  LorryListViewController.swift
//  ADongPr
//
//  Created by Cuongvh on 5/21/20.
//  Copyright © 2020 zamio. All rights reserved.
//

import UIKit

class ListWorkerViewController: BaseViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    var data = [Worker]()
    fileprivate var activityIndicator: LoadMoreActivityIndicator!
    var page = 0
    var totalPages = 0
    @IBOutlet weak var tbView: UITableView!
    @IBOutlet weak var header: NavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        tbView.dataSource = self
        tbView.delegate = self
        tbView.register(CommonTableViewCell.nib, forCellReuseIdentifier: CommonTableViewCell.identifier)
        activityIndicator = LoadMoreActivityIndicator(scrollView: tbView, spacingFromLastCell: 10, spacingFromLastCellWhenLoadMoreActionStart: 60)
        
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        data.removeAll()
        getData()
    }
    
    func setupHeader() {
        header.title = "Công Nhân"
        header.leftAction = {
            self.navigationController?.popViewController(animated: true)
        }
        
        header.rightAction = {
            if let vc = UIStoryboard.init(name: "Worker", bundle: Bundle.main).instantiateViewController(withIdentifier: "CreateWorkerViewController") as? CreateWorkerViewController {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func getData() {
        showLoading()
        APIClient.getWorkers(page : page, name : searchBar.text ?? "") { result in
            self.stopLoading()
            switch result {
            case .success(let response):
                
                if(response.data != nil) {
                    self.data = response.data!
                    self.tbView.reloadData()
                    
                    self.totalPages = response.pagination?.totalPages as! Int
                    
                } else {
                    self.showToast(content: response.message!)
                }
                
            case .failure(let error):
                  self.showToast(content: error.localizedDescription)
            }
        }
    }
    
}

extension ListWorkerViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommonTableViewCell.identifier, for: indexPath) as! CommonTableViewCell
        cell.setDataWorker(data: data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard.init(name: "Worker", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailWorkerViewController") as? DetailWorkerViewController {
            vc.id = data[indexPath.row].id!
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(page < totalPages) {
        activityIndicator.start {
                   DispatchQueue.global(qos: .utility).async {[weak self] in
                      self!.page = self!.page + 1
                      print(self!.page)
                       sleep(1)
                       DispatchQueue.main.async { [weak self] in
                           self?.activityIndicator.stop()
                       }
                   }
               }
        }
     }
}

