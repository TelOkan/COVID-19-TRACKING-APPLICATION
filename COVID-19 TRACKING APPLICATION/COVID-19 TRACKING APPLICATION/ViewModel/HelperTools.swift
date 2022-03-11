//
//  HelperTools.swift
//  COVID-19 TRACKING APPLICATION
//
//  Created by Okan on 3.03.2022.
//

import Foundation
import UIKit
class HelperTools{
    
    func getDetails (dataCarrier : [DataCarrier], detailPage : DetailsPageController) -> String {
        // to write came from api call response into details page screen.
        let times = dataCarrier[0].time
        let startIndex =  times.index(times.startIndex, offsetBy: 11)
        let endIndex =  times.index(times.startIndex, offsetBy: 15)
        let hour = times[startIndex...endIndex]
        let releaseDate = ("\(dataCarrier[0].day) \(String(hour))")
        detailPage.timeLabel.text = releaseDate  
        let countryName = dataCarrier[0].countryName
        detailPage.countryNameLabel.text = countryName
        detailPage.caseNewLabel.text = dataCarrier[0].caseNew
        detailPage.deathNewLabel.text = dataCarrier[0].deathNew
        checkInfo(label: detailPage.caseCriticalLabel, value: dataCarrier[0].caseCritical)
        checkInfo(label: detailPage.caseActiveLabel, value: dataCarrier[0].caseActive )
        checkInfo(label: detailPage.caseRecoveredLabel, value: dataCarrier[0].caseRecovered)
        checkInfo(label: detailPage.caseTotalLabel, value: dataCarrier[0].caseTotal)
        checkInfo(label: detailPage.testTotalLabel, value: dataCarrier[0].testTotal)
        checkInfo(label: detailPage.deathTotalLabel, value: dataCarrier[0].deathTotal)
        
        return countryName
    }
    
    func checkInfo (label : UILabel , value : Int){ //at the api call response some data's coming as a nil. so i am checking it is nil or not.
        if value != -1 {
            label.text = String(value)
        }else {
            label.text = "N/A"
        }
    }
    
    func sendMessage(detailPage : DetailsPageController)->String{ //  to detail screen details data share to any social media or save as note.
        let shareMassage = " \(detailPage.countryNameLabel.text!) \n \(detailPage.lastReleaseTextLabel.text!) \(detailPage.timeLabel.text!) \n\n \(detailPage.caseDetailsTextLabel.text!) \n \(detailPage.caseNewTextLabel.text!)  \(detailPage.caseNewLabel.text!) \n \(detailPage.caseActiveTextLabel.text!)  \(detailPage.caseActiveLabel.text!) \n \(detailPage.caseCriticalTextLabel.text!)  \(detailPage.caseCriticalLabel.text!) \n \(detailPage.caseRecoveredTextLabel.text!)  \(detailPage.caseRecoveredLabel.text!) \n \(detailPage.caseTotalTextLabel.text!)  \(detailPage.caseTotalLabel.text!) \n\n \(detailPage.testsDetailsTextLabel.text!) \n \(detailPage.testTotalTextLabel.text!)  \(detailPage.testTotalLabel.text!)\n\n \(detailPage.deathDetailsTextLabel.text!) \n \(detailPage.deathNewTextLabel.text!)  \(detailPage.deathNewLabel.text!)\n \(detailPage.deathTotalTextLabel.text!)  \(detailPage.deathTotalLabel.text!) "
        return shareMassage
    }
    
    func errorMessage(controller : UIViewController){ //this is simple notification to user screen as massage.
        
        let alertController = UIAlertController(title: "Veri Aktarım Hatası", message: "Şeçmiş olduğunuz tarihte, ilgili ülkenin verileri mevcut değil. Lütfen farklı bir tarih seçiniz.", preferredStyle: .alert)
        let tamamAction = UIAlertAction(title: "Tamam", style: .cancel){ action in
        }
        
        alertController.addAction(tamamAction)
        
        controller.present(alertController, animated: true)
    }
    
    func addToDataCarrier (countryModel: [CountriesModel]){ // to fill  all information inside to singleton prenciple. i am accessing everywhere all information with this way.
        
        DataCarrier.shared.removeAll()
        for (i,item) in countryModel.enumerated() {
            let values = DataCarrier(countryNo: i, countryName: item.countryName, day: item.day, time: item.time, caseNew: item.caseNew ?? "N/A", caseActive: item.caseActive ?? -1, caseCritical: item.caseCritical ?? -1, caseRecovered: item.caseRecovered ?? -1, caseTotal: item.caseTotal ?? -1, deathNew: item.deathNew ?? "N/A", deathTotal: item.deathTotal ?? -1, testTotal: item.testTotal ?? -1)
            DataCarrier.shared.append(values)
            
        }
    }
    
    //to rid tableview separator
    func tableViewSeparator(tableView : UITableView){
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }
    
    
    //below code lines to get before date from current date.
   
        var dayDate : Date? = nil
        var historyDate : [String] = []
        var dayDateString : String? = nil
        let dateFormatter1 = DateFormatter()
       
        func getBeforeDays(days : Int)-> [String] {
            dateFormatter1.dateFormat = "yyyy-MM-dd"
            for  i in 1...days {
                
                dayDate = Calendar.current.date(byAdding: .day, value: -i, to: Date())
                
                dayDateString = dateFormatter1.string(from : dayDate!)
                historyDate.append(dayDateString!)
            }
            
             return historyDate
        }
    
}
