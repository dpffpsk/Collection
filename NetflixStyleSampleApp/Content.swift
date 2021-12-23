//
//  Content.swift
//  NetflixStyleSampleApp
//
//  Created by 이니텍 on 2021/12/23.
//

import Foundation
import UIKit

//읽기 기능만 사용하기때문에 Decodable
struct Content: Decodable {
    let sectionType: SectionType
    let sectonName: String
    let contentItem: [Item]
    
    enum SectionType: String, Decodable {
        case basic
        case main
        case large
        case rank
    }
}

struct Item: Decodable {
    let description: String
    let imageName: String
    
    //포스터 이미지
    var image: UIImage {
        return UIImage(named: imageName) ?? UIImage()
    }
}

