//
//  ViewController.swift
//  MVVMModelYazmak
//
//  Created by Mehmet Samet Eğerci on 6.07.2024.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController,UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicetionView: UIActivityIndicatorView!
    var cryptsList = [Cryptos]()
    var cryptoVM = CryptoViewModel()
    var disposedBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        //tableView.dataSource = self
        //tableView.delegate = self
        tableView.rx.setDelegate(self).disposed(by: disposedBag)
        setupBindings()
        cryptoVM.requestData()
        
    }
    
    private func setupBindings() {
        
        cryptoVM
            .loading
            .bind(to: self.indicetionView.rx.isAnimating)
            .disposed(by: disposedBag)
        
        
        cryptoVM
            .error
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { errorString in
                print(errorString)
            }.disposed(by: disposedBag)
      /*  cryptoVM
            .cryptos
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { crptoss in
                self.cryptsList = crptoss
                self.tableView.reloadData()
           }.disposed(by: disposedBag)
       */
        // yukarıdaki işlemi oluşturduğumuz cell de göstermek için böyle bir şey yaptık CryptoTableViewCell de var kodun temeli
        cryptoVM.cryptos
            .observe(on: MainScheduler.asyncInstance)
            
            .bind(to: tableView.rx.items(cellIdentifier: "CryptoCell", cellType: CryptoTableViewCell.self)) {row,item,cell in
                    
                cell.item = item
                
            }
            .disposed(by: disposedBag)
    
        
    }
    
    
    
    
    /*
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptsList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = cryptsList[indexPath.row].currency
        content.secondaryText = cryptsList[indexPath.row].price
        cell.contentConfiguration = content
        return cell
    }
    
    */


}

