//
//  ImageView.swift
//  BasicSwiftUIPractice
//
//  Created by Joy Kim on 9/5/24.
//

import SwiftUI

struct ImageView: View {
    
    @Binding var sectionTitle: String
    @Environment(\.dismiss) var dismiss
    
    var image: Image
    var body: some View {
        VStack {
            image
                .scaledToFit()
                .frame(width: 120, height: 170)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            TextField("sectionTitle", text: $sectionTitle)
                .onSubmit {
                   
                    dismiss()
                }
                
        }
    }
}

