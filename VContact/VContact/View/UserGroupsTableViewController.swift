//
//  GroupsTableViewController.swift
//  VContact
//
//  Created by Mikhail Shendrikov on 10.05.2022.
//

import UIKit
import Alamofire

protocol chengeUserGroups {
    func chengeUserGroups()
}

class UserGroupsTableViewController: UITableViewController {

    var groupsArray: Array<GroupsResponse> = []
    var allGroups: Array<Group> = [Group(title: "KiteSerfing"), Group(title: "Cosmos"),Group(title: "Programming", selected: true),Group(title: "Serfing", selected: true),Group(title: "Formula1")]
    var userGroups: Array<Group> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = VKService().getURL(requestMethod: .getGroups)
        Alamofire.request(url).responseJSON(completionHandler: {data in 
            guard let data = data.data else { return }
            let groups = try? JSONDecoder().decode(GroupsResponse.self, from: data)
            self.groupsArray = groups?.response.items as! Array<GroupsResponse>
            
        })
        
        
        let cellNibType = UINib(nibName: "PhotoNameCell", bundle: nil)
        tableView.register(cellNibType, forCellReuseIdentifier: "PhotoNameType")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        updateUserGroups(groups: userGroups)
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUserGroups()
    }
    
    private func updateUserGroups(groups: [Group]){
        userGroups = groups
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userGroups.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoNameType", for: indexPath) as! PhotoNameCell
        cell.name.text = userGroups[indexPath.row].title
        cell.avatar.image = UIImage(imageLiteralResourceName: "Groups/\(userGroups[indexPath.row].title)")

        return cell
    }
  
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let conAction = UIContextualAction(style: .destructive, title: "Delete", handler: {_,_,_ in
            var index: Int = 0
            self.allGroups.forEach({group in
                if group == self.userGroups[indexPath.row]{
                    self.allGroups[index].selected = false
                   }
                index += 1
            })
            self.getUserGroups()
            tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
        })
        let action = UISwipeActionsConfiguration(actions: [conAction])
        return action
    }

    @IBAction func chooseGroup(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destenationView = storyboard.instantiateViewController(withIdentifier: "AllGroupsTableViewController") as! AllGroupsTableViewController
        destenationView.allGroupsChoose = allGroups
        destenationView.updeteUserGroup = {[self] group in
            allGroups = group
            getUserGroups()
            tableView.reloadData()
        }
        self.navigationController?.pushViewController(destenationView, animated: true)
    }
    
    func getUserGroups() {
        userGroups.removeAll()
        allGroups.forEach({group in
            if group.selected, !userGroups.contains(group){
                userGroups.append(group)
            }
        })
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
