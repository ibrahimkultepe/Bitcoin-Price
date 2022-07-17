//
//  ViewModel.swift
//  Bitcoin Price
//
//  Created by İbrahim Kültepe on 12.07.2022.
//

import Foundation

class BitcoinPriceViewModel {
    
    var getDataDidSuccess: (() -> ())?
    var detailsModels = [TableViewCellModel]()
    var numberOfItems: Int {
        return detailsModels.count
    }
    
    func cellItemForAt(indexPath: IndexPath) -> TableViewCellModel {
        return detailsModels[indexPath.row]
    }
    
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { [weak self] (data, response, error)  in
                guard let self = self else { return }
                if let safeData = data {
                    self.parseJSON(safeData)
                    print(safeData)
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ detailsData: Data) -> TableViewCellModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinDeskResponse.self, from: detailsData)
            let rate = decodedData.bpi.usd.rate
            let code = decodedData.bpi.usd.code
            
            let usd = TableViewCellModel(code: code, rate: rate)
            self.getDataDidSuccess?()
            return usd
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
