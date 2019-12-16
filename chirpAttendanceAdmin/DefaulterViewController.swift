//
//  DefaulterViewController.swift
//  chirpAttendanceAdmin
//
//  Created by Garima Bothra on 14/12/19.
//  Copyright © 2019 Garima Bothra. All rights reserved.
//

import UIKit
import Firebase

class DefaulterViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    var userArray : [User] = [User]()
    override func viewDidLoad() {
        super.viewDidLoad()
        defaulterTableView.register(UINib(nibName: "AttendeeTableViewCell", bundle: nil), forCellReuseIdentifier: "AttendeeCell")
               configureTableView()
               retrieveusers()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var defaulterTableView: UITableView!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
      let cell = tableView.dequeueReusableCell(withIdentifier: "AttendeeCell", for: indexPath) as! AttendeeTableViewCell
        cell.userName.text = userArray[indexPath.row].name
        cell.userMail.text = userArray[indexPath.row].mail
        cell.user_id.text = userArray[indexPath.row].userid
    return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userArray.count
    }
    func retrieveusers()
    {
        referroom.child("defaulters").observe(DataEventType.value, with: {(snapshot) in
        for snap in snapshot.children.allObjects {
        let id = snap as! DataSnapshot
        var referuser = Database.database().reference().child("users").child(id.value as! String)
        referuser.observe(DataEventType.value, with: {(snapshot) in
        
        let value = snapshot.value as? NSDictionary
        let username = value?["name"] as? String ?? ""
        let usermail = value?["email"] as? String ?? ""
        let userid = value?["user_id"] as? String ?? ""
        let user = User()
            user.name = username
            user.mail = usermail
            user.userid = userid
       self.userArray.append(user)
           self.configureTableView()
           self.defaulterTableView.reloadData()
       }){ (error) in
           print(error.localizedDescription)
       }
            }
        })
    }
    func configureTableView()
    {
        defaulterTableView.rowHeight = UITableView.automaticDimension
        defaulterTableView.estimatedRowHeight = 120
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