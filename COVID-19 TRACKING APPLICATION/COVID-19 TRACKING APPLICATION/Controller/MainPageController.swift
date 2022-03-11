//
//  ViewController.swift
//  COVID-19 TRACKING APPLICATION
//
//  Created by Okan on 1.03.2022.
//

import UIKit

class MainPageController: UIViewController , CountryManagerDelegate, UIGestureRecognizerDelegate{
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    @IBOutlet weak var mainPageTableView: UITableView!
    var searchResults : [DataCarrier] = []
    var apiManager = ApiManager()
    var refreshControl = UIRefreshControl()
    var helperTools = HelperTools()
    var indexNo : Int?
    var typedText : String?
    var refresh : UIRefreshControl {
        let ref = UIRefreshControl ()
        ref.addTarget(self, action: #selector (clearTextbox(_:)), for: .valueChanged)
        return ref
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        apiManager.delegate = self
        mainPageTableView.delegate = self
        mainPageTableView.dataSource = self
        searchBar.delegate = self
        apiManager.getData() // i have requested api call.
        helperTools.tableViewSeparator(tableView: mainPageTableView) // to rid from tableview separator lines.
        mainPageTableView.addSubview(refresh) // related with refresh of tableview to pull down gesture
        
    }
    
    
    @IBAction func detailsButton(_ sender: UIButton) {
        indexNo = sender.tag
        performSegue(withIdentifier: "goToDetailsPage", sender: nil)
        
    }
    
    func getCountriesData(_ modelManager: ApiManager, _ countryModel: [CountriesModel]) {
        //api call will be comeback here with api response.
        
        DispatchQueue.main.async { //when async situation finish. reload tableView otherwise every time we see white screen :) this mean never tableView will be load.
            self.helperTools.addToDataCarrier(countryModel: countryModel)
            DataCarrier.shared.sort(by: {$0.countryName < $1.countryName}) //this code line provides displays the list of countries in alphabetical order.
            self.mainPageTableView.reloadData() // i have refreshed tableView Screen
            
        }
    }
    
    
}

extension MainPageController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if typedText == nil || typedText == ""{ //i have arranged from where search bar or normal to count of tableView row
            return DataCarrier.shared.count
        }else {
            return searchResults.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainPageTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainPageTableViewCell
        
        cell.detailsButton.tag = DataCarrier.shared[indexPath.row].countryNo // i have embeeded inside of the button index numbers to direct toggle relative detail page.
        cell.countryNameView.layer.cornerRadius = cell.countryNameView.frame.height / 6 //radius of tableview cell
        if typedText == nil || typedText == "" { //i have arranged from where search bar or normal
            
            cell.countryNameLabel.text = DataCarrier.shared[indexPath.row].countryName
            
            let confirmedTestState = DataCarrier.shared[indexPath.row].testTotal
            helperTools.checkInfo(label: cell.confirmedTestLabel, value: confirmedTestState)
            
            let deathTollState = DataCarrier.shared[indexPath.row].deathTotal
            helperTools.checkInfo(label: cell.deathTollLabel, value: deathTollState)
            
            
            let caseSate = DataCarrier.shared[indexPath.row].caseTotal
            helperTools.checkInfo(label: cell.casesLabel, value: caseSate)
            
            
            
            
        }else { // if i were came form search bar so below code lines will be work.
            
            cell.countryNameLabel.text = searchResults[indexPath.row].countryName
            cell.detailsButton.tag = searchResults[indexPath.row].countryNo
            
            let confirmedTestState = searchResults[indexPath.row].caseTotal
            helperTools.checkInfo(label: cell.confirmedTestLabel, value: confirmedTestState)
            
            let deathTollState =  searchResults[indexPath.row].deathTotal
            helperTools.checkInfo(label: cell.deathTollLabel, value: deathTollState)
            
            let caseSate = searchResults[indexPath.row].testTotal
            helperTools.checkInfo(label: cell.casesLabel, value: caseSate)
            
        }
        
        return cell
    }
    
    @objc func clearTextbox(_ control : UIRefreshControl) { //pullDown gesture working here to clean entire main page.
        typedText?.removeAll()
        searchBar.text?.removeAll()
        searchResults.removeAll()
        mainPageTableView.reloadData()
        control.endRefreshing()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailsPage" {
            if let destinationPage = segue.destination as? DetailsPageController {
                destinationPage.indexNo = self.indexNo // i am going to detail page with index number to open relative country data's.
            }
        }
    }
    
    
    
}

extension MainPageController : UISearchBarDelegate  {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) { // i am getting here writed text from searchBar
        typedText?.removeAll()
        typedText = searchText
        searchResults = DataCarrier.shared.filter({$0.countryName.contains(typedText!)})
        mainPageTableView.reloadData()
        
        
    }
}
