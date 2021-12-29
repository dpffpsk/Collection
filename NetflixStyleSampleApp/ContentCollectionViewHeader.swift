//
//  ContentCollectionViewHeader.swift
//  NetflixStyleSampleApp
//
//  Created by 이니텍 on 2021/12/23.
//

import Foundation
import UIKit

//UICollectionReusableView 타입의 경우에만 header, footer 생성 가능
class ContentCollectionViewHeader: UICollectionReusableView {
    let sectionNameLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        sectionNameLabel.font = .systemFont(ofSize: 17, weight: .bold)
        sectionNameLabel.textColor = .white
        sectionNameLabel.sizeToFit()
        
        addSubview(sectionNameLabel)
        
        //Add New Constraints
        //위, 아래, 왼쪽 10씩 간격
        sectionNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.top.bottom.leading.equalToSuperview().offset(10)
        }
    }
}
