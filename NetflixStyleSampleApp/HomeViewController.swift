//
//  HomeViewController.swift
//  NetflixStyleSampleApp
//
//  Created by 이니텍 on 2021/12/22.
//

import Foundation
import UIKit
import SwiftUI //미리보기 하기 위해

class HomeViewController: UICollectionViewController {
    var contents: [Content] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //네비게이션바 설정
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.hidesBarsOnSwipe = true //스와이프 액션시(스크롤시) 네비게이션바 숨김
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "netflix_icon"), style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"), style: .plain, target: nil, action: nil)
        
        //Data 설정, 가져오기
        contents = getContents()
        
        //CollectionViewCell, Header 등록
        collectionView.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: "ContentCollectionViewCell")
        collectionView.register(ContentCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ContentCollectionViewHeader")
        collectionView.collectionViewLayout = layout()
    
    }
    
    //.plist 값 가져오도록
    func getContents() -> [Content] {
        guard let path = Bundle.main.path(forResource: "Content", ofType: "plist"),
              let data = FileManager.default.contents(atPath: path),
              let list = try? PropertyListDecoder().decode([Content].self, from: data) else { return [] }
        return list
    }
    
    //SectionType에 대한 UICollectionViewLayout 생성
    private func layout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout {[weak self] sectionNumber, environment -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            
            switch self.contents[sectionNumber].sectionType {
            case .basic:
                return self.createBasicTypeSection()
            default:
                return nil
            }
        }
    }
    
    //SectionType = basic 경우 설정
    private func createBasicTypeSection() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(0.75))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 0, trailing: 5)
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous //스크롤 행위 설정
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        //해당 타입에서만 헤더 설정(main의 경우 필요 x)
        let sectionHeader = self.createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    //SectionType = large 경우 설정
    private func createLargeTypeSection() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(0.75))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 0, trailing: 5)
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(400))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous //스크롤 행위 설정
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        //해당 타입에서만 헤더 설정(main의 경우 필요 x)
        let sectionHeader = self.createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]

        
        return section
    }
    
    //SectionHeader layout 설정
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        
        //Section Header 사이즈
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30))
        
        //Section Header Layout
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        return sectionHeader
    }
}

//UICollectionView DataSource, Delegate
extension HomeViewController {
    //섹션당 보여질 셀의 개수
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        //임시로 basic의 경우만 출력되도록
        if contents[section].sectionType == .basic {
            switch section {
            case 0: //첫 줄에는 무조건 추천하는 작품 한 개로
                return 1
            default:
                return contents[section].contentItem.count
            }
        }
        return 0
    }
    
    //CollectionViewCell 설정
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch contents[indexPath.section].sectionType {
        case .basic, .large:
            guard let cell: ContentCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewCell", for: indexPath) as? ContentCollectionViewCell else { return UICollectionViewCell() }
            cell.imageView.image = contents[indexPath.section].contentItem[indexPath.row].image
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    //CollectionViewHeader 설정
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ContentCollectionViewHeader", for: indexPath) as? ContentCollectionViewHeader else { fatalError("Could not dequeue Header")}
            
            headerView.sectionNameLabel.text = contents[indexPath.section].sectionName
            return headerView
        } else {
            return UICollectionReusableView()
        }
    }
    
    //섹션 개수 설정
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return contents.count
    }
    
    
    //셀 선택
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionName = contents[indexPath.section].sectionName
        print("TEST: \(sectionName)섹션의 \(indexPath.row + 1)번째 콘텐츠")
    }
}

//SwiftUI를 활용한 미리보기
struct HomeViewController_Previews: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            let layout = UICollectionViewLayout()
            let homeViewController = HomeViewController(collectionViewLayout: layout)
            return UINavigationController(rootViewController: homeViewController)
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
        
        typealias UIViewControllerType = UIViewController
    }
}

