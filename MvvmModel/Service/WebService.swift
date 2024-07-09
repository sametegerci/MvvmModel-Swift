//
//  WebService.swift
//  MVVMModelYazmak
//
//  Created by Mehmet Samet Eğerci on 6.07.2024.
//

import Foundation
import UIKit


enum CryptoError :  Error {
    case serveError
    case ParsingError
}


class CryptoService {
    
    
    func downloadCurriens(url: URL, completion: @escaping (Result<[Cryptos],CryptoError>) -> ()) { // kendi completionHandlerımı oluşturdum
        // onun için escapibg kullandık resulttan sonra <> arasına ilk önce succes olanı sonrada failiuer olanın yazdık failuer anum içinde verilenlerdir
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.serveError)) // ilk başta hata alırsak sarver hatası verdik
            }else if let data = data {
                // eğer data geldiyse onu JsonDecoder ile dönüştürmemiz lazım
                let cryptoList = try? JSONDecoder().decode([Cryptos].self, from: data) // buradaki Cryptos model olan cryptos ama burada veri belki gelmeyeceği için try da yapmamızı istiyor
                if let cryptoList = cryptoList {
                    completion(.success(cryptoList))
                    
                }else {
                    completion(.failure(.ParsingError)) // veri gelirde işlenemezse parsin error verilir
                }
            }
        }.resume()
    }
    
    
    
}
