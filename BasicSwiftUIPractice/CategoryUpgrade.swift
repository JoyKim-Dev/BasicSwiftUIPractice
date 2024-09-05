//
//  CategoryUpgrade.swift
//  BasicSwiftUIPractice
//
//  Created by Joy Kim on 9/5/24.
//

import SwiftUI


struct Category {
    let id = UUID()
    var name: String
    var count: Int
}


struct CategoryUpgrade: View {

    let item = ["SF", "가족", "스릴러"]
    
   @State private var searched: String = ""
    @State private var addedItemList:[Category] = []
    
    var body: some View {
        NavigationView {
            List {
                ForEach(addedItemList, id: \.id) { item in
                    HStack {
                        Image(systemName: "person")
                        Text("\(item.name)(\(item.count))")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    
                }
            }
          //  .listStyle(DefaultListStyle())
                .navigationTitle("영화 검색")
                .searchable(text: $searched, prompt: "영화를 검색해보세요")
                .toolbar(content: {
                    Button("추가") {
                       let result =  Category(name: item.randomElement()!, count: .random(in: 1...100))
                        self.addedItemList.append(result)
                    }
                })
            
        }
    }
    
 
    
    
}

#Preview {
    CategoryUpgrade()
}
