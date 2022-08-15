//
//  Entity.swift
//  CovidApp
//
//  Created by 山崎颯汰 on 2022/08/16.
//

import Foundation

struct CovidInfo: Codable{
    
    struct Total: Codable{
        var pcr: Int
        var positive: Int
        var hospitalize: Int
        var severe: Int
        var death: Int
        var discharge: Int
    }
}
