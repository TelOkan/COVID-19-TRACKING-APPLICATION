//
//  CountryData.swift
//  COVID-19 TRACKING APPLICATION
//
//  Created by Okan on 1.03.2022.
//

import Foundation
//to get api call response here have to same with rapid api response(json) struct.
struct CountriesData : Codable {
    let response : [statisticsData]
    struct statisticsData : Codable {
        let country : String
        let day : String
        let time : String

        let cases : Cases
        struct Cases : Codable {
            let new : String?
            let critical : Int?
            let active : Int?
            let recovered : Int?
            let total : Int?
        }
        
        
        let deaths : Deaths
        struct Deaths : Codable {
            let new : String?
            let total : Int?
        }
        
        let tests : Tests
        struct Tests : Codable {
            let total : Int?
        }
        
    }
}



