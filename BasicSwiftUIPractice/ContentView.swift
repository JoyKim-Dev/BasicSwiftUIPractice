//
//  ContentView.swift
//  BasicSwiftUIPractice
//
//  Created by Joy Kim on 8/22/24.
//

import SwiftUI

struct ContentView: View {
    
    private func cardView(image: String, text: String) -> some View {
        VStack(spacing: 10) {
            Image(systemName: image)
            Text(text)
        }
        .padding()
        .background(.blue.opacity(0.2))
    }
    
    private func secondCardView(image: String, text: String) -> some View {
        HStack(spacing: 10) {
            Image(systemName: image)
            Text(text)
        }
        .padding()
        .background(.black)
    }
    
    var body: some View {
        ZStack {
            Color(.black)
        VStack(alignment: .center){
            HStack() {
                cardView(image: "house", text: "토스뱅크")
                cardView(image: "heart", text: "토스증권")
                cardView(image: "star", text: "고객센터")
                
                
            }
            .foregroundColor(.white)
            .background(.black)
            Text("포인트를 더 모을 수 있게 맞춤 혜택을 추천해드릴까요?")
                .foregroundStyle(.white)
                .font(.title3)
                .multilineTextAlignment(.leading
                )
            VStack(alignment:.leading) {
                    secondCardView(image: "house", text: "토스뱅크")
                    secondCardView(image: "heart", text: "토스증권")
                    secondCardView(image: "star", text: "고객센터")
                   
                }
                .foregroundColor(.white)
            }
        
            
        }
    }
}

#Preview {
    ContentView()
}
