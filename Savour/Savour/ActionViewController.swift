//
//  ActionViewController.swift
//  Savour
//
//  Created by FNSPL on 26/01/21.
//  Copyright © 2021 FNSPL. All rights reserved.
//

import UIKit
import CoreData
class ActionViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var arrInvitee = [Invitee]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        getAllInvitee()
    }
    func getAllInvitee(){
        let arr = Invitee.fetchAll()
        
        arrInvitee = arr
        tableView.reloadData()
        
    }
    
    @IBAction func clickedudpate(_ sender: Any) {
        let arr = Invitee.fetchAll()
        print(arr.count)
        print(arr.first?.status_dining)
        updateDiningStatus(with: StatusDining.notStarted.status, for: arr.first!.name!)
    }
    
    func updateDiningStatus(with status: Int, for name: String){
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Invitee")

        fetchRequest.predicate = NSPredicate(format: "name = %@",
                                                 argumentArray: [name])

        do {
            let results = try AppDelegate.viewContext.fetch(fetchRequest) as? [NSManagedObject]
            if results?.count != 0 { // Atleast one was returned

                // In my case, I only updated the first item in results
                results![0].setValue(status, forKey: "status_dining")
            }
        } catch {
            print("Fetch Failed: \(error)")
        }

        do {
            try AppDelegate.viewContext.save()
            self.getAllInvitee()
           }
        catch {
            print("Saving Core Data Failed: \(error)")
        }
    }
    func updateAttendanceStatus(with status: Int, for name: String){
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Invitee")

        fetchRequest.predicate = NSPredicate(format: "name = %@",
                                                 argumentArray: [name])

        do {
            let results = try AppDelegate.viewContext.fetch(fetchRequest) as? [NSManagedObject]
            if results?.count != 0 { // Atleast one was returned

                // In my case, I only updated the first item in results
                results![0].setValue(status, forKey: "status_attendance")
            }
        } catch {
            print("Fetch Failed: \(error)")
        }

        do {
            try AppDelegate.viewContext.save()
            self.getAllInvitee()
           }
        catch {
            print("Saving Core Data Failed: \(error)")
        }
    }
    func updateReturnStatus(with status: Int, for name: String){
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Invitee")

        fetchRequest.predicate = NSPredicate(format: "name = %@",
                                                 argumentArray: [name])

        do {
            let results = try AppDelegate.viewContext.fetch(fetchRequest) as? [NSManagedObject]
            if results?.count != 0 { // Atleast one was returned

                // In my case, I only updated the first item in results
                results![0].setValue(status, forKey: "status_return")
            }
        } catch {
            print("Fetch Failed: \(error)")
        }

        do {
            try AppDelegate.viewContext.save()
            self.getAllInvitee()
           }
        catch {
            print("Saving Core Data Failed: \(error)")
        }
        
    }
    
    func updateIsRibhuStatus(with status: Bool, for name: String){
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Invitee")

        fetchRequest.predicate = NSPredicate(format: "name = %@",
                                                 argumentArray: [name])

        do {
            let results = try AppDelegate.viewContext.fetch(fetchRequest) as? [NSManagedObject]
            if results?.count != 0 { // Atleast one was returned

                // In my case, I only updated the first item in results
                results![0].setValue(status, forKey: "isRibhu")
            }
        } catch {
            print("Fetch Failed: \(error)")
        }

        do {
            try AppDelegate.viewContext.save()
            self.getAllInvitee()
           }
        catch {
            print("Saving Core Data Failed: \(error)")
        }
    }

}
extension ActionViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrInvitee.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellAction") as! ActionTableViewCell
        cell.holderVw.layer.cornerRadius = 5.0
        cell.holderVw.layer.masksToBounds = true
        cell.shadowVw.layer.cornerRadius = 5.0
        cell.shadowVw.layer.shadowColor = UIColor.lightGray.cgColor
        cell.shadowVw.layer.shadowRadius = 5.0
        cell.shadowVw.layer.shadowOpacity = 0.3
        cell.shadowVw.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        let invitee = arrInvitee[indexPath.row]
        cell.vwIndicator.backgroundColor = invitee.isRibhu ? UIColor(hexString: "AD58258") : UIColor(hexString: "A8A676")
        cell.lblName.text = invitee.name ?? ""
        switch invitee.status_attendance {
        case 1:
            cell.lblAttendance.text = StatusAttendance.notComing.words
            case 2:
            cell.lblAttendance.text = StatusAttendance.notYetPresent.words
            case 3:
            cell.lblAttendance.text = StatusAttendance.present.words
            
        default:
            cell.lblAttendance.isHidden = true
        }
        if invitee.status_attendance == 3{
            cell.lblDining.isHidden = false
            cell.lblReturn.isHidden = false
            switch invitee.status_dining {
            case 1:
                cell.lblDining.text = StatusDining.notStarted.words
                case 2:
                cell.lblDining.text = StatusDining.havingFood.words
                case 3:
                cell.lblDining.text = StatusDining.completed.words
                
            default:
                cell.lblDining.isHidden = true
            }
            switch invitee.status_return {
            case 1:
                cell.lblReturn.text = StatusReturn.notReturning.words
                case 2:
                cell.lblReturn.text = StatusReturn.stillHere.words
                case 3:
                cell.lblReturn.text = StatusReturn.returned.words
                
            default:
                cell.lblReturn.isHidden = true
            }
        }
        else{
            cell.lblDining.isHidden = true
            cell.lblReturn.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //throw action sheet accrodingly
        let invitee = arrInvitee[indexPath.row]
        let name = invitee.name ?? ""
        if invitee.status_attendance == StatusAttendance.present.status{
            if invitee.status_dining == StatusDining.completed.status{
                let actionSheetController = UIAlertController(title: "Update Return for", message: name, preferredStyle: .actionSheet)
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in}
                actionSheetController.addAction(cancelAction)
                let presentAction = UIAlertAction(title: "Returned", style: .default) { action -> Void in
                    self.updateReturnStatus(with: 3, for: name)
                }
                actionSheetController.addAction(presentAction)

                let notComingAction = UIAlertAction(title: "Not Returning", style: .destructive) { action -> Void in
                   self.updateReturnStatus(with: 1, for: name)
                }
                actionSheetController.addAction(notComingAction)
                self.present(actionSheetController, animated: true, completion: nil)
            }
            else{
                let actionSheetController = UIAlertController(title: "Update Dining for", message: name, preferredStyle: .actionSheet)
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in}
                actionSheetController.addAction(cancelAction)
                let presentAction = UIAlertAction(title: "Completed", style: .default) { action -> Void in
                    self.updateDiningStatus(with: 3, for: name)
                }
                actionSheetController.addAction(presentAction)

                let notComingAction = UIAlertAction(title: "Having food", style: .default) { action -> Void in
                   self.updateDiningStatus(with: 2, for: name)
                }
                actionSheetController.addAction(notComingAction)
                self.present(actionSheetController, animated: true, completion: nil)
            }
        }
        else{
            
            let actionSheetController = UIAlertController(title: "Update Attendance for", message: name, preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in}
            actionSheetController.addAction(cancelAction)
            let presentAction = UIAlertAction(title: "Present", style: .default) { action -> Void in
//                self.updateIsRibhuStatus(with: false, for: name)
                self.updateAttendanceStatus(with: 3, for: name)
            }
            actionSheetController.addAction(presentAction)

            let notComingAction = UIAlertAction(title: "Not Coming Today", style: .destructive) { action -> Void in
               self.updateAttendanceStatus(with: 1, for: name)
            }
            actionSheetController.addAction(notComingAction)
            self.present(actionSheetController, animated: true, completion: nil)
        }
        
    }
}
