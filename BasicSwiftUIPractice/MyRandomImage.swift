//
//  MyRandomImage.swift
//  BasicSwiftUIPractice
//
//  Created by Joy Kim on 9/5/24.
//

import SwiftUI

struct SectionTitle {
    let id = UUID()
    var title: String
    
    
    init(title: String) {
        self.title = title
    }
}

struct MyRandomImage: View {
    
//    @State private var title: [String] = [
//        "기분좋은 랜덤사진",
//        "눈이 편한 랜덤사진",
//        "찜해둔 사진",
//        "인기 사진 목록"
//    ]
       
    @State private var list:[SectionTitle] = [
        
        SectionTitle(title: "기분좋은 랜덤사진"),
        SectionTitle(title: "눈이 편한 랜덤사진"),
        SectionTitle(title:  "찜해둔 사진"),
        SectionTitle(title: "인기 사진 목록")
            ]
    
    init() {
        print("MediaView init")
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach($list, id: \.id) {
                    $item in
                    makeSection($item.title)
                }
            }
            .navigationTitle("My Random Image")
        }
    }
        
    func makeSection(_ title: Binding<String>) -> some View {
         
            return VStack {
                Text(title.wrappedValue)
                    .font(.title3)
                    .bold()
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HorizontalSectionView(sectionTitle: title)
            }
        }
    }

#Preview {
    MyRandomImage()
}
