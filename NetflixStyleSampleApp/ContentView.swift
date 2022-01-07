//
//  ContentView.swift
//  NetflixStyleSampleApp
//
//  Created by 이니텍 on 2022/01/07.
//

import SwiftUI

struct ContentView: View {
    let titles = ["Netflix Sample App"]
    
    var body: some View {
        NavigationView { //네비게이션 바 사용하려면
            List(titles, id: \.self) { //리스트 선언
                let netflixVC = HomeViewControllerRepresentable()
                    .navigationBarHidden(true) //네비게이션 바 숨김
                    .edgesIgnoringSafeArea(.all) //전체화면
                NavigationLink($0, destination: netflixVC) //titles, 다음 화면
            }
            .navigationBarTitle("SwiftUI to UIKit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
