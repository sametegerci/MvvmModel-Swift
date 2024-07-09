//
//  viewModel.swift
//  MVVMModelYazmak
//
//  Created by Mehmet Samet Eğerci on 6.07.2024.
//

import Foundation
import RxSwift
import RxCocoa

class CryptoViewModel {
    let cryptos : PublishSubject<[Cryptos]> = PublishSubject()
    let error : PublishSubject<String> = PublishSubject()
    let loading : PublishSubject<Bool> = PublishSubject()
    
    
    
    
    
    func requestData() {
        loading.onNext(true)
        
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
        CryptoService().downloadCurriens(url: url) { result in
            self.loading.onNext(false)
            switch result {
            case .success(let crypts):
                self.cryptos.onNext(crypts)
                
            case .failure(let error):
                switch error {
                case .ParsingError:
                    self.error.onNext("Parsing Error")
                case .serveError:
                    self.error.onNext("Server Error")
                }
            }
        }
        
        
    }
    
}
