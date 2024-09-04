//
//  CoinVIewNavigation.swift.swift
//  BasicSwiftUIPractice
//
//  Created by Joy Kim on 9/4/24.
//

import SwiftUI

struct CoinVIewNavigation: View {
    
    @State private var market: [Market] = []
    @State private var searched: String = ""
    @State private var favoriteCoins: Set<String> = []
    var bannerText:[Banner] { [Banner(total: market.count, title: "전체 코인"), Banner(total: favoriteCoins.count, title: "관심 코인")]}
    
    var filteredData: [Market] {
        guard !searched.isEmpty else { return market }
        return market.filter { coin in
            coin.englishName.contains(searched)
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    horizontalBannerView()
                    listView()
                }
            }
            .refreshable {
                await callRequest()
            }
            .searchable(text: $searched, prompt: "코인검색")
            .navigationTitle("My Coin")
            .foregroundStyle(.purple)
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
            print("error")
        }
    }
    
    func horizontalBannerView() -> some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(bannerText, id: \.id) { i in
                    bannerView(i)
      //                  .containerRelativeFrame(.horizontal)
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned/*.paging*/)
        .scrollIndicators(.hidden)
    }
    
    func bannerView(_ banner: Banner) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(banner.color)
                .overlay(alignment: .leading) {
                    Circle()
                        .fill(.white.opacity(0.3))
                        .scaleEffect(2)
                        .offset(x: -60, y: 10.0)
                }
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .frame(height: 150)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
            VStack(alignment: .leading) {
                Spacer()
                Text(banner.title)
                    .font(.callout)
                Text(banner.totalFormat)
                    .font(.title).bold()
            }
            .foregroundStyle(.white)
            .padding(40)
            .frame(width: UIScreen.main.bounds.width / 2, alignment: .center)
        }
    }
    
    
    func rowView(_ item: Market) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.englishName)
                    .fontWeight(.bold)
                Text(item.koreanName)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            Spacer()
            HStack {
                Text(item.market)
                Image(systemName: favoriteCoins.contains(item.market) ? "heart.fill" : "heart")
                    .onTapGesture {
                        toggleFavorite(for: item)
                    }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 6)
    }
    
    func listView() -> some View {
        LazyVStack {
            ForEach(filteredData, id: \.self) { item in
                NavigationLink {
                    NavigationLazyView(MyCoinView(item: item, favoriteCoins: $favoriteCoins))
                } label: {
                    rowView(item)
                }
            }
        }
    }
}

struct MyCoinView: View {
    var item: Market
    @Binding var favoriteCoins: Set<String>
    
    var body: some View {
        VStack(alignment: .center) {
            VStack(alignment: .center) {
                Text(item.englishName)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                HStack(alignment: .center) {
                    Text(item.koreanName)
                        .font(.headline)
                        .foregroundStyle(.gray)
                    Text(item.market)
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
            }
            Image(systemName: favoriteCoins.contains(item.market) ? "heart.fill" : "heart")
                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor( .purple.opacity(0.5))
                
                .frame(width: 100, height: 100)
                .padding()
                .onTapGesture {
                    toggleFavorite(for: item)
                }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 6)
    }
    
    func toggleFavorite(for item: Market) {
        if favoriteCoins.contains(item.market) {
            favoriteCoins.remove(item.market)
        } else {
            favoriteCoins.insert(item.market)
        }
    }
}

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    var body: some View {
        build()
    }
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
        print("navigationLazyView Init")
    }
}
    
    
    #Preview {
        CoinVIewNavigation()
    }
