//
//  DetailsPageController.swift
//  COVID-19 TRACKING APPLICATION
//
//  Created by Okan on 2.03.2022.
//

import UIKit

class DetailsPageController: UIViewController {
  //here too much @IBOutlet cause of the api call response values.
    var helperTools = HelperTools()
    var countryName : String?
    var indexNo : Int?
    var detailResult : [DataCarrier] = []
    var releaseDate : String = ""
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var caseNewLabel: UILabel!
    @IBOutlet weak var caseActiveLabel: UILabel!
    @IBOutlet weak var caseCriticalLabel: UILabel!
    @IBOutlet weak var caseRecoveredLabel: UILabel!
    @IBOutlet weak var caseTotalLabel: UILabel!
    @IBOutlet weak var testTotalLabel: UILabel!
    @IBOutlet weak var deathNewLabel: UILabel!
    @IBOutlet weak var deathTotalLabel: UILabel!
    @IBOutlet weak var caseDetailsTextLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var testsDetailsTextLabel: UILabel!
    @IBOutlet weak var deathDetailsTextLabel: UILabel!
    @IBOutlet weak var lastReleaseTextLabel: UILabel!    
    @IBOutlet weak var caseNewTextLabel: UILabel!
    @IBOutlet weak var caseActiveTextLabel: UILabel!
    @IBOutlet weak var caseCriticalTextLabel: UILabel!
    @IBOutlet weak var caseRecoveredTextLabel: UILabel!
    @IBOutlet weak var caseTotalTextLabel: UILabel!
    @IBOutlet weak var testTotalTextLabel: UILabel!
    @IBOutlet weak var deathNewTextLabel: UILabel!
    @IBOutlet weak var deathTotalTextLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if indexNo != nil { // if i were came with indexNumber , this mean  is , i came from main page so that api call response will be diffent from came from historypage
            detailResult = (DataCarrier.shared.filter({$0.countryNo == indexNo}))
            
           countryName = helperTools.getDetails(dataCarrier: detailResult, detailPage: self)
        }else { // if i  come  from history page below code line will be work. here api call response different cause of selected date.
           countryName = helperTools.getDetails(dataCarrier: DataCarrier.shared, detailPage: self)
        }
       
    }
       
    @IBAction func seeHistoryButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToHistoryPage", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToHistoryPage" {
            if let destinationPage = segue.destination as? HistoryPageController {
                destinationPage.countryName = countryName //i send country name to history page to understand this history belong who is.
            }
        }
    }
    
    @IBAction func shareButtonPressed(_ sender: UIButton) { //this code lines to share details page data's to any social media or save as note.
        
        let massage = helperTools.sendMessage(detailPage: self)
        let activityVC = UIActivityViewController(activityItems: [massage], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
}
