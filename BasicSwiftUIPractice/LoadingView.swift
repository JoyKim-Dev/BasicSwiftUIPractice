//
//  LoadingView.swift
//  BasicSwiftUIPractice
//
//  Created by Joy Kim on 9/2/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("HELLO, \nMY POLAROID")
                    .font(.system(size: 35, weight: .black, design: .serif)) // FontDesign 설정
                    .fontWeight(.black)
                    .foregroundStyle(.blue)
                    .tracking(3.0) // 글자 사이간격 설정
                Image("launchImage")
                
                NavigationLink {
                    ProfileSettingView()
                } label: {
                    Text("시작하기")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 40)
                        .background(Color.blue)
                        .cornerRadius(25)
                }
                .padding(.top, 100)
                
                
            }
        }
    }
}

#Preview {
    LoadingView()
}
