//
//  ContentCollectionViewCell.swift
//  NetflixStyleSampleApp
//
//  Created by 이니텍 on 2021/12/23.
//

import Foundation
import SnapKit
import UIKit

class ContentCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        
        contentView.addSubview(imageView)
        
        //Add New Constraints
        //이미지뷰 크기에 맞춰서
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
