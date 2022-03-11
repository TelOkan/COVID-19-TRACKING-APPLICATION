//
//  HistoryPageController.swift
//  COVID-19 TRACKING APPLICATION
//
//  Created by Okan on 2.03.2022.
//

import UIKit

class HistoryPageController: UIViewController, CountryManagerDelegate {
   
    
    
 

  
    var dates : [String] = []
    var selectedDate : String? = nil
    var countryName : String? = nil
    var apiManager = ApiManager()
    var helperTools = HelperTools()
    
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var historyTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        apiManager.delegate = self
        historyTableView.delegate = self
        historyTableView.dataSource = self
        helperTools.tableViewSeparator(tableView: historyTableView)
        dates = helperTools.getBeforeDays(days: 10) //days value mean history page date quantity from today. it is dynamic you can change.
        countryNameLabel.text = countryName!
    }
    
    func getCountriesData(_ modelManager: ApiManager, _ countryModel: [CountriesModel]) {
      
               
        DispatchQueue.main.async { //when async situation finish. reload tableView otherwise every time we see white screen :) this mean never tableView will be load.
            
            if countryModel.count != 0{ //if api call response is not nil , below two code lines work.
            self.helperTools.addToDataCarrier(countryModel: countryModel) 
            self.performSegue(withIdentifier: "goToDetailPageFromHistory", sender: nil)
            }else { // i realize that in some date data's coming as nil. they haven't any data belong selected date. so i writed here as if the api call response is nill , send to a massege to user to select another date.
                self.helperTools.errorMessage(controller: self)
            }
        }
    }

}

extension HistoryPageController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyTableView.dequeueReusableCell(withIdentifier: "cell" , for : indexPath) as! HistoryPageViewCell
        cell.historyLabel.text = dates[indexPath.row] //listed relative dates.
        cell.historyView.layer.cornerRadius = cell.historyView.frame.height / 6
       return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedDate = nil
        selectedDate = dates[indexPath.row]
        apiManager.getData(countryName: countryName!, date: selectedDate!) //when select any date , api call will be start. and then this page leading to details page.
    }
    
}
