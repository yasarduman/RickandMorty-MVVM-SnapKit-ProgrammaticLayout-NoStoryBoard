//
//  RickyMortyViewController.swift
//  RickAndMorty
//
//  Created by Yaşar Duman on 3.10.2023.
//

import UIKit
import SnapKit

protocol RickyMortyOutPut {
    func changeLoading(isLoad: Bool)
    func saveDatas(value: [Result])
}

//final başka bir class tarafından türetilmesini engeller
final class RickyMortyViewController: UIViewController {
    
    private let labelTitle: UILabel                = UILabel()
    private let tableView: UITableView             = UITableView()
    private let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    private lazy var results: [Result] = []
    lazy var viewModel: IRickyMortyViewModel = RickyMortyViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
     
        configure()
        viewModel.setDelegate(output: self)
        viewModel.fetchItems()
    }
    
   private func configure() {
        view.addSubview(labelTitle)
        view.addSubview(tableView)
        view.addSubview(indicator)
      
        
        drawDesign()
        makeLabel()
        makeIndicator()
        makeTableView()
       
    }
    
    private func drawDesign() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RickyMortyTableViewCell.self, forCellReuseIdentifier: RickyMortyTableViewCell.Identifier.custom.rawValue)
        tableView.rowHeight = self.view.frame.size.height * 0.21
        DispatchQueue.main.async {
            self.view.backgroundColor = .white
            self.labelTitle.text      = "Ricky Morty"
            self.labelTitle.font      = .boldSystemFont(ofSize: 25)
            self.indicator.color      = .red
        }
        self.indicator.startAnimating()
    }

  

}

extension RickyMortyViewController: RickyMortyOutPut {
    func changeLoading(isLoad: Bool) {
        isLoad ? indicator.startAnimating() : indicator.stopAnimating()
    }
    
    func saveDatas(value: [Result]) {
        results = value
        tableView.reloadData()
    }
    
    
}

extension RickyMortyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: RickyMortyTableViewCell = tableView.dequeueReusableCell(withIdentifier: RickyMortyTableViewCell.Identifier.custom.rawValue, for: indexPath) as? RickyMortyTableViewCell else {
            return UITableViewCell()
        }
        
        cell.saveModel(model: results[indexPath.row])
        return cell
    }
    
    
}


extension RickyMortyViewController {
    private func makeLabel() {
        labelTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.height.greaterThanOrEqualTo(10) //en az 10 ve fazlası ola bilir docu incele
        }
    }
    
    private func makeIndicator() {
        indicator.snp.makeConstraints { make in
            make.height.equalTo(labelTitle)
            make.right.equalTo(labelTitle).offset(-5)
            make.top.equalTo(labelTitle)
        }
    }
    
    private func makeTableView() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(labelTitle.snp.bottom).offset(5)
            make.bottom.equalToSuperview()
            make.left.right.equalTo(labelTitle)
        }
    }
    
   
}
