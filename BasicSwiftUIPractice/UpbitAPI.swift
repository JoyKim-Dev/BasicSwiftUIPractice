//
//  UpbitAPI.swift
//  BasicSwiftUIPractice
//
//  Created by Joy Kim on 9/3/24.
//

import Foundation
import SwiftUI

struct Market: Hashable, Codable {
    let market, koreanName, englishName: String

    // 디코딩값 코딩키로 변환
    enum CodingKeys: String, CodingKey {
        case market
        case koreanName = "korean_name"
        case englishName = "english_name"
    }
}

typealias Markets = [Market]

struct UpbitAPI {
    
    private init() { }

    // completionhandler가 아닌 리턴값으로 받게된다면..

    static func fetchAllMarket() async throws -> Markets {
        
        let url = URL(string: "https://api.upbit.com/v1/market/all")!
        
        // 네트워크 요청 시 응답이 올 때까지 이 코드라인에서 기다리겠다!라는 코드 (비동기지만 실은 동기처럼 작동하는 것..)
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // 응답값이 오고 나서야 이 코드가 실행이 되어서 원했던 데이터로 가공이 가능해짐.
        let decodedData = try JSONDecoder().decode(Markets.self, from: data)
        
        return decodedData
    }
    
//    static func fetchAllMarket(completion: @escaping (Markets) -> Void) {
//
//        let url = URL(string: "https://api.upbit.com/v1/market/all")!
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data else { return }
//            do {
//                let decodedData = try JSONDecoder().decode(Markets.self, from: data)
//                DispatchQueue.main.async {
//                    completion(decodedData)
//                }
//            } catch {
//                print(error)
//            }
//        }.resume()
//    }
}
