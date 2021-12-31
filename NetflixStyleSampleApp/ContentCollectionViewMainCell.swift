//
//  ContentCollectionViewMainCell.swift
//  NetflixStyleSampleApp
//
//  Created by 이니텍 on 2021/12/30.
//

import Foundation
import UIKit

class ContentCollectionViewMainCell: UICollectionViewCell {
    let baseStackView = UIStackView() //내용 전체를 담는 뷰
    let menuStackView = UIStackView() //상단의 카테고리 메뉴 뷰(baseStackView 위에 올려짐)
    
    //menuStackView 안의 버튼
    let tvButton = UIButton()
    let movieButton = UIButton()
    let categoryButton = UIButton()
    
    //baseStackView 안의 뷰
    let imageView = UIImageView()
    let descriptionLabel = UILabel()
    let contentStackView = UIStackView() //버튼들을 담는 뷰
    
    //contentStackView 안의 버튼
    let plusButton = UIButton()
    let playButton = UIButton()
    let infoButton = UIButton()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //baseStackView, menuStackView 설정
        [baseStackView, menuStackView].forEach {
            contentView.addSubview($0)
        }
        
        //baseStackView 레이아웃
        baseStackView.axis = .vertical
        baseStackView.alignment = .center
        baseStackView.distribution = .fillProportionally
        baseStackView.spacing = 5
        //baseStackView autolayout
        baseStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        //menuStackView 레이아웃
        menuStackView.axis = .horizontal
        menuStackView.alignment = .center
        menuStackView.distribution = .equalSpacing
        menuStackView.spacing = 20
        //menuStackView autolayout
        menuStackView.snp.makeConstraints {
            $0.top.equalTo(baseStackView)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        //menuStackView의 버튼 설정
        [tvButton, movieButton, categoryButton].forEach {
            menuStackView.addArrangedSubview($0)
            $0.setTitleColor(.white, for: .normal)
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOpacity = 1
            $0.layer.shadowRadius = 3
        }
        //menuStackView의 버튼 타이틀
        tvButton.setTitle("TV 프로그램", for: .normal)
        movieButton.setTitle("영화", for: .normal)
        categoryButton.setTitle("카테고리 ▾", for: .normal)
        //menuStackView의 버튼 클릭시 기능
        tvButton.addTarget(self, action: #selector(tvButtonTapped), for: .touchUpInside)
        movieButton.addTarget(self, action: #selector(movieButtonTapped), for: .touchUpInside)
        categoryButton.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        
        
        //baseStackView 안의 뷰 설정
        [imageView, descriptionLabel, contentStackView].forEach {
            baseStackView.addArrangedSubview($0)
        }
        //baseStackView - imageView
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints {
            $0.width.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(imageView.snp.width)
        }
        //baseStackView - descriptionLabel
        descriptionLabel.font = .systemFont(ofSize: 13)
        descriptionLabel.textColor = .white
        descriptionLabel.sizeToFit()
        //baseStackView - contentStackView
        contentStackView.axis = .horizontal
        contentStackView.alignment = .center
        contentStackView.distribution = .equalCentering
        contentStackView.spacing = 20
        //contentStackView autolayout
        contentStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(60)
        }
        
        //contentStackView 안의 버튼 설정
        [plusButton, infoButton].forEach {
            $0.titleLabel?.font = .systemFont(ofSize: 13)
            $0.setTitleColor(.white, for: .normal)
            $0.imageView?.tintColor = .white
            $0.adjustVerticalLayout(5)
        }
        plusButton.setTitle("내가 찜한 콘텐츠", for: .normal)
        plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        
        infoButton.setTitle("정보", for: .normal)
        infoButton.setImage(UIImage(systemName: "info.circle"), for: .normal)
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        
        playButton.setTitle("► 재생", for: .normal)
        playButton.setTitleColor(.black, for: .normal)
        playButton.backgroundColor = .white
        playButton.layer.cornerRadius = 3
        
        //playButton autolayout
        playButton.snp.makeConstraints {
            $0.width.equalTo(90)
            $0.height.equalTo(30)
        }
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        
        //출력되는 순서 재설정
        [plusButton, playButton, infoButton].forEach {
            contentStackView.addArrangedSubview($0)
        }
    }
    @objc func tvButtonTapped(sender: UIButton!) { print("TEST: TV Button Tapped") }
    @objc func movieButtonTapped(sender: UIButton!) { print("TEST: Moive Button Tapped") }
    @objc func categoryButtonTapped(sender: UIButton!) { print("TEST: Category Button Tapped") }
    @objc func plusButtonTapped(sender: UIButton!) { print("TEST: Plus Button Tapped") }
    @objc func infoButtonTapped(sender: UIButton!) { print("TEST: Info Button Tapped") }
    @objc func playButtonTapped(sender: UIButton!) { print("TEST: Info Button Tapped") }
}
