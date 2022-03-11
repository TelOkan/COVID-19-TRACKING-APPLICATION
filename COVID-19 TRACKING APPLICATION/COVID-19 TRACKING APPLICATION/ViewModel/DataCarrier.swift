//
//  DataCarrier.swift
//  COVID-19 TRACKING APPLICATION
//
//  Created by Okan on 1.03.2022.
//

import Foundation
class DataCarrier { // i have created a data carrier to access every data from anywhere with singleton prenciple.
static var shared = [DataCarrier]().self
    
    let countryNo   : Int
    let countryName : String
    let day : String
    let time : String
    let caseNew : String
    let caseActive : Int
    let caseCritical : Int
    let caseRecovered : Int
    let caseTotal : Int
    let deathNew : String
    let deathTotal : Int
    let testTotal : Int

init(countryNo : Int,countryName : String, day : String,time : String,caseNew : String,caseActive : Int,caseCritical : Int,caseRecovered : Int,caseTotal : Int,deathNew : String,deathTotal : Int,testTotal : Int) {
    self.countryNo   = countryNo
    self.countryName = countryName
    self.day = day
    self.time = time
    self.caseNew = caseNew
    self.caseActive = caseActive
    self.caseCritical = caseCritical
    self.caseRecovered = caseRecovered
    self.caseTotal = caseTotal
    self.deathNew = deathNew
    self.deathTotal = deathTotal
    self.testTotal = testTotal
}
}
