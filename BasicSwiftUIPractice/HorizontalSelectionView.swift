//
//  HorizontalSelectionView.swift
//  BasicSwiftUIPractice
//
//  Created by Joy Kim on 9/5/24.
//
import SwiftUI

struct HorizontalSectionView: View {
    @Binding var sectionTitle: String
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(0..<10) {
                    item in
                    PosterView(sectionTitle: $sectionTitle)
                }
            }
        }
    }
}
