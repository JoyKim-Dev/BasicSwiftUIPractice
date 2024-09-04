//
//  Banner.swift
//  BasicSwiftUIPractice
//
//  Created by Joy Kim on 9/4/24.
//

import SwiftUI

//struct Banner: Hashable, Identifiable {
//    let id = UUID()
//    var total = Int.random(in: 1000...5000) * 150
//    let color = Color.random()
//    
//    var totalFormat: String {
//        return String(total.formatted()) + "원"
//    }
//}

struct Banner {
    let id = UUID()
    var total: Int
    var title: String
    let color = Color.random()
    
    var totalFormat: String {
        return "\(total)개"
    }
    
    init(total: Int, title: String) {
        self.total = total
        self.title = title
    }
}

extension Color {
    static func random() -> Color {
        return Color(red: .random(in: 0...1),
                     green: .random(in: 0...1),
                     blue: .random(in: 0...1)
        )
    }
}
