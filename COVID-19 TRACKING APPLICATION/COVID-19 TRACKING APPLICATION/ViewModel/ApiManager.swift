//
//  ApiManager.swift
//  COVID-19 TRACKING APPLICATION
//
//  Created by Okan on 1.03.2022.
//

import Foundation
import UIKit
protocol CountryManagerDelegate { //I used protokols and Delegates to Carrier data between of the screens.
    func getCountriesData(_ modelManager : ApiManager , _ countryModel : [CountriesModel])
}
struct ApiManager { //here for api call and json parse transactions.
    var delegate : CountryManagerDelegate?
    let headers = [
        "x-rapidapi-host": "covid-193.p.rapidapi.com",
        "x-rapidapi-key": "09ce5a4ddfmshbabe6a0cd52da12p11dfa8jsn01dc1c42728f"
    ]

    var request : NSMutableURLRequest?
  
    mutating func getData (){
         request = NSMutableURLRequest(url: NSURL(string:"https://covid-193.p.rapidapi.com/statistics")! as URL,
cachePolicy: .useProtocolCachePolicy,timeoutInterval: 10.0)
        getCountries()
    }
    
    
    mutating func getData(countryName : String , date : String) {
        request = NSMutableURLRequest(url: NSURL(string:"https://covid-193.p.rapidapi.com/history?country=\(countryName)&day=\(date)")! as URL,
cachePolicy: .useProtocolCachePolicy,timeoutInterval: 10.0)
       getCountries()
    }
    
    func getCountries(){
        
        request!.httpMethod = "GET"
        request!.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request! as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            } else {
                if let safeData = data {
                    
                 
                    if let  arrayCountry = self.parseJson(safeData){
                        self.delegate?.getCountriesData(self, arrayCountry)
                    }
                }
            }
        })

        dataTask.resume()
    }
    
    
    
    
    
    func parseJson(_ countryData : Data) -> [CountriesModel]? {
        let decoder = JSONDecoder()
        var countryModel = [CountriesModel]()
        do{
            let decodedData = try decoder.decode(CountriesData.self, from: countryData)
        
           for item in decodedData.response {
              
                
                 countryModel.append(CountriesModel(countryName: item.country, day: item.day, time: item.time, caseNew: item.cases.new, caseActive: item.cases.active, caseCritical: item.cases.critical , caseRecovered: item.cases.recovered, caseTotal: item.cases.total, deathNew: item.deaths.new, deathTotal: item.deaths.total, testTotal: item.tests.total))
            
               
                
            }
            return countryModel
        }
        catch{
            print(error)
            return nil
        }
        
    }
 
}
