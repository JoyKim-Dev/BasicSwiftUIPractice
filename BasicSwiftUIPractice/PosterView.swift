//
//  PosterView.swift
//  BasicSwiftUIPractice
//
//  Created by Joy Kim on 9/5/24.
//

import SwiftUI

struct PosterView: View {
    
    @Binding var sectionTitle: String
    
    let url = URL(string: "https://picsum.photos/200/300")
    
    var body: some View {
        AsyncImage(url: url) {data in
            switch data {
            case .empty:
                ProgressView()
                    .frame(width: 200, height: 300)
            case .success(let image):
                let image = image
                NavigationLink {
                    ImageView(sectionTitle: $sectionTitle, image: image)
                } label: {
                    image
                        .scaledToFit()
                        .frame(width: 120, height: 170)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
            case .failure(_):
                Image(systemName: "star")
                    .frame(width: 200, height: 300)
            @unknown default:
                Image(systemName: "star")
                    .frame(width: 200, height: 300)
            }
        }
    }
}

