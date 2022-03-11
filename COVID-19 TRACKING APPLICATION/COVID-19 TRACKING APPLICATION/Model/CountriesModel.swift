//
//  CountriesModel.swift
//  COVID-19 TRACKING APPLICATION
//
//  Created by Okan on 1.03.2022.
//

import Foundation


   
struct CountriesModel  { //i am sending as countriesModel to screens.
    
    let countryName : String
    let day : String
    let time : String
    let caseNew : String?
    let caseActive : Int?
    let caseCritical : Int?
    let caseRecovered : Int?
    let caseTotal : Int?
    let deathNew : String?
    let deathTotal : Int?
    let testTotal : Int?
}






