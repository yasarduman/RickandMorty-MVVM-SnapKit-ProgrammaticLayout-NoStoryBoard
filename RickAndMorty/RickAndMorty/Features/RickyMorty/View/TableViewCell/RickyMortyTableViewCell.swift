//
//  RickyMortyTableViewCell.swift
//  RickAndMorty
//
//  Created by Yaşar Duman on 3.10.2023.
//

import UIKit
import AlamofireImage

class RickyMortyTableViewCell: UITableViewCell {

    private let customimage: UIImageView         = UIImageView()
    private let title: UILabel             = UILabel()
    private let customDescription: UILabel = UILabel()
    
    private let randomImage: String = "https://picsum.photos/200/300"
    
    enum Identifier: String {
        case custom = "vb10"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(customimage)
        addSubview(title)
        addSubview(customDescription)
        title.font = .boldSystemFont(ofSize: 18)
        customDescription.font = .italicSystemFont(ofSize: 10)
        
        customimage.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.top.equalTo(contentView)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        title.snp.makeConstraints { make in
            make.top.equalTo(customimage.snp.bottom).offset(10)
            make.right.left.equalTo(customimage)
            
        }
        
        customDescription.snp.makeConstraints { make in
            make.top.equalTo(title).offset(5)
            make.right.left.equalTo(title)
            make.bottom.equalToSuperview()
        }
    }
    
    func saveModel(model: Result) {
        title.text = model.name
        customDescription.text = model.status
        customimage.af.setImage(withURL: URL(string: model.image ?? randomImage)! )
    }
    
}
