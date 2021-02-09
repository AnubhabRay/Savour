//
//  AddViewController.swift
//  Savour
//
//  Created by FNSPL on 26/01/21.
//  Copyright © 2021 FNSPL. All rights reserved.
//

import UIKit
import CoreData

class AddViewController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var btnMini: UIButton!
    @IBOutlet weak var btnRibhu: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        btnRibhu.isSelected = true
        // Do any additional setup after loading the view.
        
        
    }
    
    @IBAction func clickedAdd(_ sender: UIButton) {
//        Invitee.deleteAll()
//        return
        
        let arr = Invitee.fetchAll()
        print(arr.count)
        guard let text = txtName.text else{return}
        if (text.trimmingCharacters(in: .whitespaces).count) > 0{
            saveInvitee(named: text)
        }
    }
    @IBAction func clickedRibhu(_ sender: UIButton) {
        btnRibhu.isSelected = true
        btnMini.isSelected = false
    }
    @IBAction func clickedMini(_ sender: UIButton) {
        btnRibhu.isSelected = false
        btnMini.isSelected = true
    }
    
    private func saveInvitee(named name: String) {
        
        let task = Invitee(context: AppDelegate.viewContext)
        task.name = name
        task.isRibhu = btnRibhu.isSelected
        task.status_attendance = 2
        task.status_dining = 1
        task.status_return = 2
        try? AppDelegate.viewContext.save()

        txtName.text = nil
        btnRibhu.isSelected = true
        btnMini.isSelected = false
        
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
