//
//  LoadingCompleteView.swift
//  BasicSwiftUIPractice
//
//  Created by Joy Kim on 9/2/24.
//

import SwiftUI

struct LoadingCompleteView: View {
    
     var dataFromPreviousView: String
    
    var body: some View {
        Text(dataFromPreviousView)
            .font(.title2)
            .bold()
    }
}


