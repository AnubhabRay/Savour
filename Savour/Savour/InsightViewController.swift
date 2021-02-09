//
//  InsightViewController.swift
//  Savour
//
//  Created by FNSPL on 26/01/21.
//  Copyright © 2021 FNSPL. All rights reserved.
//

import UIKit
import PieCharts

class InsightViewController: UIViewController {
    
    @IBOutlet weak var pieChartAttendanceHolder: UIView!
    @IBOutlet weak var vwShadowAttendance: UIView!
    @IBOutlet weak var vwHolderAttendance: UIView!
    @IBOutlet weak var lblPresent: UILabel!
    @IBOutlet weak var lblYettoCome: UILabel!
    
    @IBOutlet weak var vwShadowDining: UIView!
    @IBOutlet weak var vwHolderDining: UIView!
    @IBOutlet weak var lblDineComplete: UILabel!
    @IBOutlet weak var lblDineYetto: UILabel!
    @IBOutlet weak var pieChartHolderDining: UIView!
    
    @IBOutlet weak var vwShadowReturn: UIView!
    @IBOutlet weak var vwHolderReturn: UIView!
    @IBOutlet weak var lblReturned: UILabel!
    @IBOutlet weak var lblYettoReturn: UILabel!
    @IBOutlet weak var vwHolderPichartReturn: UIView!
    
    @IBOutlet weak var vwShadowDemo: UIView!
    @IBOutlet weak var vwHolderDemo: UIView!
    @IBOutlet weak var lblCountRibhu: UILabel!
    @IBOutlet weak var lblCountMini: UILabel!
    @IBOutlet weak var vwHolderPiechartDemo: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        setup()
    }
    override func viewDidAppear(_ animated: Bool) {
        setData()
    }
    func setup(){
        vwHolderAttendance.layer.cornerRadius = 10
        vwHolderAttendance.layer.masksToBounds = true
        pieChartAttendanceHolder.layer.cornerRadius = 75
        
        
        vwShadowAttendance.layer.cornerRadius = 10.0
        vwShadowAttendance.layer.shadowColor = UIColor.lightGray.cgColor
        vwShadowAttendance.layer.shadowRadius = 5.0
        vwShadowAttendance.layer.shadowOpacity = 0.3
        vwShadowAttendance.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        vwHolderDining.layer.cornerRadius = 10
        vwHolderDining.layer.masksToBounds = true
        pieChartHolderDining.layer.cornerRadius = 75
        
        vwShadowDining.layer.cornerRadius = 10.0
        vwShadowDining.layer.shadowColor = UIColor.lightGray.cgColor
        vwShadowDining.layer.shadowRadius = 5.0
        vwShadowDining.layer.shadowOpacity = 0.3
        vwShadowDining.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        vwHolderReturn.layer.cornerRadius = 10
        vwHolderReturn.layer.masksToBounds = true
        vwHolderPichartReturn.layer.cornerRadius = 75
        
        vwShadowReturn.layer.cornerRadius = 10.0
        vwShadowReturn.layer.shadowColor = UIColor.lightGray.cgColor
        vwShadowReturn.layer.shadowRadius = 5.0
        vwShadowReturn.layer.shadowOpacity = 0.3
        vwShadowReturn.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        vwHolderDemo.layer.cornerRadius = 10
        vwHolderDemo.layer.masksToBounds = true
        vwHolderPiechartDemo.layer.cornerRadius = 75
        
        vwShadowDemo.layer.cornerRadius = 10.0
        vwShadowDemo.layer.shadowColor = UIColor.lightGray.cgColor
        vwShadowDemo.layer.shadowRadius = 5.0
        vwShadowDemo.layer.shadowOpacity = 0.3
        vwShadowDemo.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        
    }
    func setData(){
        let arr = Invitee.fetchAll()
        let arrComing = arr.filter { (invitee) -> Bool in
            return (invitee.status_attendance == 1) ? false : true
        }
        let arrPresent = arrComing.filter { (invitee) -> Bool in
            return (invitee.status_attendance == 3) ? true : false
        }
        let yetToCome = arrComing.count - arrPresent.count
        setPieChartAttendance(present: arrPresent.count, yetTo: yetToCome)
        
        let arrCompleted = arrComing.filter { (invitee) -> Bool in
            return (invitee.status_dining == 1) ? false : true
        }
        let yetToEat = arrComing.count - arrCompleted.count
        setPieChartDining(completed: arrCompleted.count, yetTo: yetToEat)
        
        let arrReturned = arrComing.filter { (invitee) -> Bool in
            return (invitee.status_return == 3) ? true : false
        }
        let yetToReturned = arrComing.count - arrReturned.count
        setPieChartReturn(returned: arrReturned.count, yetTo: yetToReturned)
        
        let arrRibhu = arrComing.filter { (invitee) -> Bool in
            return (invitee.isRibhu) ? true : false
        }
        let countMini = arrComing.count - arrRibhu.count
        setPieChartDemo(ribhu: arrRibhu.count, mini: countMini)
        
        
    }
    
    func setPieChartAttendance(present : Int, yetTo: Int){
        let vwDelete = pieChartAttendanceHolder.viewWithTag(191)
        vwDelete?.removeFromSuperview()
        let pieChartAttendance = PieChart(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        pieChartAttendanceHolder.addSubview(pieChartAttendance)
        pieChartAttendance.tag = 191
        pieChartAttendance.innerRadius = 25.0
        pieChartAttendance.outerRadius = 75.0
        let arrSlices = [
            PieSliceModel(value: Double(present), color: UIColor(hexString: "A8A676")),
            PieSliceModel(value: Double(yetTo), color: UIColor(hexString: "ECB984"))
        ]
        pieChartAttendance.models = arrSlices
        
        lblPresent.text = "\(present) present"
        if yetTo > 0{
            lblYettoCome.text = "\(yetTo) yet to come"
        }
        else{
            lblYettoCome.text = "Everyone's here"
        }
    }
    func setPieChartDining(completed : Int, yetTo: Int){
        let vwDelete = pieChartHolderDining.viewWithTag(192)
        vwDelete?.removeFromSuperview()
        let pieChartAttendance = PieChart(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        pieChartHolderDining.addSubview(pieChartAttendance)
        pieChartAttendance.tag = 192
        pieChartAttendance.innerRadius = 25.0
        pieChartAttendance.outerRadius = 75.0
        let arrSlices = [
            PieSliceModel(value: Double(completed), color: UIColor(hexString: "D58258")),
            PieSliceModel(value: Double(yetTo), color: UIColor(hexString: "ECB984"))
        ]
        pieChartAttendance.models = arrSlices
        
        lblDineComplete.text = "\(completed) done"
        if yetTo > 0{
            lblDineYetto.text = "\(yetTo) not yet"
        }
        else{
            lblDineYetto.text = "Everyone's done"
        }
    }
    
    func setPieChartReturn(returned : Int, yetTo: Int){
        let vwDelete = vwHolderPichartReturn.viewWithTag(193)
        vwDelete?.removeFromSuperview()
        let pieChartAttendance = PieChart(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        vwHolderPichartReturn.addSubview(pieChartAttendance)
        pieChartAttendance.tag = 193
        pieChartAttendance.innerRadius = 25.0
        pieChartAttendance.outerRadius = 75.0
        let arrSlices = [
            PieSliceModel(value: Double(returned), color: UIColor(hexString: "963A2F")),
            PieSliceModel(value: Double(yetTo), color: UIColor(hexString: "ECB984"))
        ]
        pieChartAttendance.models = arrSlices
        
        lblReturned.text = "\(returned) done"
        if yetTo > 0{
            lblYettoReturn.text = "\(yetTo) not yet"
        }
        else{
            lblYettoReturn.text = "Adiós, amigo!!!"
        }
    }
    
    func setPieChartDemo(ribhu : Int, mini: Int){
        let vwDelete = vwHolderPiechartDemo.viewWithTag(193)
        vwDelete?.removeFromSuperview()
        let pieChartAttendance = PieChart(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        vwHolderPiechartDemo.addSubview(pieChartAttendance)
        pieChartAttendance.tag = 194
        pieChartAttendance.innerRadius = 25.0
        pieChartAttendance.outerRadius = 75.0
        let arrSlices = [
            PieSliceModel(value: Double(ribhu), color: UIColor(hexString: "D58258")),
            PieSliceModel(value: Double(mini), color: UIColor(hexString: "A8A676"))
        ]
        pieChartAttendance.models = arrSlices
        
        lblCountRibhu.text = "\(ribhu) by Ribhu"
        if mini > 0{
            lblCountMini.text = "\(mini) by Mini"
        }
        else{
            lblCountMini.text = "Adiós, amigo!!!"
        }
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
