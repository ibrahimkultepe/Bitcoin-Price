//
//  ViewController.swift
//  Bitcoin Price
//
//  Created by İbrahim Kültepe on 12.07.2022.
//

import TinyConstraints
import Foundation

class BitcoinPriceViewController: UIViewController {
    
    var baseURL = "https://api.coindesk.com/v1/bpi/currentprice.json"
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        return tableView
    }()
    
    private let viewModel: BitcoinPriceViewModel
    
    init(viewModel: BitcoinPriceViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.performRequest(urlString: baseURL)
        setupViews()
        subcribeViewModel()
    }
    
    //MARK: - Setup Views
    func setupViews() {
        view.addSubview(tableView)
        tableView.edgesToSuperview()
    }
}

//MARK: - UITableViewDelegate
extension BitcoinPriceViewController: UITableViewDelegate {
    
}

//MARK: - UITableViewDataSource
extension BitcoinPriceViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell {
            let cellItem = viewModel.cellItemForAt(indexPath: indexPath)
            cell.setCellItem(viewModel: cellItem)
            return cell
        }
        return UITableViewCell()
    }
}

extension BitcoinPriceViewController {
    
    func subcribeViewModel() {
            viewModel.getDataDidSuccess = { [weak self] in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
}
