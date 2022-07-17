//
//  TableViewCell.swift
//  Bitcoin Price
//
//  Created by İbrahim Kültepe on 13.07.2022.
//

import TinyConstraints

class TableViewCell: UITableViewCell {
    
    static let identifier = "CustomTableViewCell"
    var details: TableViewCellModel?

    private let stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    private let codeLabel: UILabel = {
       let codeLabel = UILabel()
        codeLabel.textColor = .cyan
        codeLabel.font = .systemFont(ofSize: 14, weight: .bold)
        return codeLabel
    }()
    
    private let rateLabel: UILabel = {
       let rateLabel = UILabel()
        rateLabel.textColor = .yellow
        rateLabel.font = .systemFont(ofSize: 14, weight: .bold)
        return rateLabel
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        contentView.addSubview(stackView)
        stackView.edgesToSuperview(insets: .init(top: 10, left: 10, bottom: 10, right: 10))
        
        stackView.addArrangedSubview(codeLabel)
        stackView.addArrangedSubview(rateLabel)
    }
    
    func setCellItem(viewModel: TableViewCellModel) {
        self.details = viewModel
        rateLabel.text = viewModel.rate
        codeLabel.text = viewModel.code
    }
}
