//
//  CoinNetworkView.swift
//  BasicSwiftUIPractice
//
//  Created by Joy Kim on 9/3/24.
//

import SwiftUI


struct CoinNetworkView: View {
    
    @State private var searchedData: [Market] = []
    @State private var searchWord:String = ""
    @State private var market: [Market] = []
    @State private var favoriteCoins: Set<String> = []
    
    var filteredData: [Market] {
        guard !searchWord.isEmpty else { return market }
        return market.filter { coin in
            coin.englishName.contains(searchWord)
        }
        
    }
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                listView(filteredData)
                
            }
            .refreshable {
                await callRequest()
            }
            .navigationTitle("Search")
            .searchable(text: $searchWord, prompt: "Search")
        }
        .task {
            await callRequest()
        }
        
        
        
    }
    
    func toggleFavorite(for item: Market) {
        if favoriteCoins.contains(item.market) {
            favoriteCoins.remove(item.market)
        } else {
            favoriteCoins.insert(item.market)
        }
    }
    
    func callRequest() async {
        do {
            let result = try await UpbitAPI.fetchAllMarket()
            market = result
        } catch {
            
        }
    }
    func rowView(_ item: Market) -> some View {
        NavigationLink(destination: LoadingCompleteView(dataFromPreviousView: item.englishName)) {
            HStack {
                Circle()
                    .frame(height: 40)
                    .overlay(alignment: .center) {
                        Image(systemName: "heart")
                            .foregroundStyle(.white)
                    }
                    .clipShape(Circle())
                    .padding()
                
                VStack(alignment: .leading) {
                    Text(item.englishName)
                        .font(.callout)
                    Text(item.market)
                        .font(.caption)
                }
                Spacer()
                Image(systemName: favoriteCoins.contains(item.market) ? "star.fill" : "star")
                    .foregroundColor(favoriteCoins.contains(item.market) ? .black: .gray)
                    .padding()
                    .onTapGesture {
                        toggleFavorite(for: item)
                    }
            }
        }
    }
    func listView(_ data : [Market]) -> some View {
        
        LazyVStack {
            ForEach(data, id: \.self) {
                item in rowView(item)
            }
        }
    }
}



#Preview {
    CoinNetworkView()
}
